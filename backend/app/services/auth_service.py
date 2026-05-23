from fastapi import HTTPException, status
from datetime import datetime, timedelta, timezone
from sqlalchemy import select
from sqlalchemy.exc import IntegrityError
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.security import(
    hash_password, verify_password, generate_recovery_code,
    create_access_token, create_refresh_token
)
from app.core.email import send_recovery_email
from app.core.config import settings
from app.schemas.auth import RegisterRequest, LoginRequest
from app.models.user import User

async def register_user(body: RegisterRequest, db: AsyncSession) -> dict:
    
    user = User(
        username=body.username,
        password_hash=hash_password(body.password),
        email=body.email,
    )

    db.add(user)

    
    try:
        await db.commit()
    except IntegrityError as e:
        await db.rollback()

        error_msg = str(e.orig).lower()
        if "username" in error_msg:
            detail = "Username already taken"
        elif "email" in error_msg:
            detail = "Email already in use"
        else:
            detail = "Something went wrong" #User registration failed due to a conflict
        
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=detail,
        )
    await db.refresh(user)
    
    return {
        "username": user.username,
        "access_token": create_access_token(str(user.id)),
        "refresh_token": create_refresh_token(str(user.id)),
    }

async def login_user(body: LoginRequest, db: AsyncSession) -> dict:
    result = await db.execute(select(User).where(User.username == body.username))
    user = result.scalar_one_or_none()

    if not user or not verify_password(body.password, user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid username or password",
        )
    if not user.is_active:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Account is inactive",
        )
    
    return {
        "access_token": create_access_token(str(user.id)),
        "refresh_token": create_refresh_token(str(user.id)),
    }

async def send_recovery_code(email: str, db: AsyncSession) -> None:
    result = await db.execute(select(User).where(User.email == email))
    user = result.scalar_one_or_none()

    #Always retun success - never reveal if email exists
    if not user:
        return
    
    code = generate_recovery_code()
    user.recovery_code = code
    user.recovery_code_expires_at = datetime.now(timezone.utc) + timedelta(
        minutes=settings.RECOVERY_CODE_EXPIRE_MINUTES
    )
    await db.commit()
    await send_recovery_email(email, code)

async def reset_password(email: str, code: str, new_password: str, db: AsyncSession):
    result = await db.execute(select(User).where(User.email == email))
    user = result.scalar_one_or_none()

    if not user or not user.recovery_code or not user.recovery_code_expires_at:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired code",
        )
    
    if user.recovery_code != code:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired code",
        )
    
    if datetime.now(timezone.utc) > user.recovery_code_expires_at:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired code",
        )
    
    user.password_hash = hash_password(new_password)
    user.recovery_code = None
    user.recovery_code_expires_at = None

    await db.commit()