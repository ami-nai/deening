from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.dependencies import get_current_user, get_db
from app.core.security import decode_token, create_access_token, create_refresh_token
from app.schemas.auth import(
    RegisterRequest, RegisterResponse,
    LoginRequest, TokenResponse,
    RefreshRequest, RecoverRequest, ResetPasswordRequest,
)
from app.services.auth_service import(
    register_user, login_user,
    send_recovery_code, reset_password,
)
from app.models.user import User

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/register", response_model=RegisterResponse, status_code=201)
async def register(body: RegisterRequest, db: AsyncSession=Depends(get_db)):
    return await register_user(body, db)

@router.post("/login", response_model=TokenResponse)
async def login(body: LoginRequest, db: AsyncSession = Depends(get_db)):
    return await login_user(body, db)

@router.post("/refresh", response_model=TokenResponse)
async def refresh(body: RefreshRequest):
    payload = decode_token(body.refresh_token)
    if not payload or payload.get("type") != "refresh":
        raise HTTPException(
            status_code=401,
            detail="Invalid refresh token",
        )
    user_id = payload.get("sub")
    return {
        "access_token": create_access_token(user_id),
        "refresh_token": create_refresh_token(user_id)
    }

@router.post("/recover") # Why TokenResponse is needed here as it's not sending tokenResponse. Or there is anything else needs to be understand 
async def recover(body: RecoverRequest, db: AsyncSession=Depends(get_db)):
    result = await send_recovery_code(body.email, db)
    return {"message": "If this email is registered, a code has been sent"}

@router.post("/reset", status_code=200)
async def reset(body: ResetPasswordRequest, db: AsyncSession=Depends(get_db)):
    await reset_password(body.email, body.code, body.new_password, db)
    return {"message": "Password reset successful"}

@router.get("/me")
async def me(current_user: User = Depends(get_current_user)):
    return {
        "id": str(current_user.id),
        "username": current_user.username,
        "has_recovery_email": current_user.email is not None,
    }
