from pydantic import BaseModel, EmailStr, field_validator
import re

class RegisterRequest(BaseModel):
    username: str
    password: str
    email: EmailStr | None = None

    @field_validator("username")
    @classmethod
    def validate_username(cls, v: str) -> str:
        v = v.strip()
        if len(v) < 3 or len(v) > 30:
            raise ValueError("Username must be between 3 and 30 characters")
        if not re.match("^[a-zA-Z0-9_]+$", v):
            raise ValueError("Username can only contain letters, numbers, underscores")
        return v
    
    @field_validator("email")
    @classmethod
    def normalize_email(cls, v: EmailStr | None) -> EmailStr | None:
        if v is None:
            return None
        return str(v).strip().lower() # EmailStr(str(v).strip().lower())

    @field_validator("password")
    @classmethod
    def validate_password(cls, v: str) -> str:
        if len(v) < 8:
            raise ValueError("Password must be at least 8 characters")
        return v
    
class RegisterResponse(BaseModel):
    username: str
    access_token: str
    refresh_token: str

class LoginRequest(BaseModel):
    username: str
    password: str

    @field_validator("username")
    @classmethod
    def normalize_username(cls, v: str) -> str:
        v = v.strip()
        if not v:
            raise ValueError("Username is required")
        return v

class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    username: str

class RefreshRequest(BaseModel):
    refresh_token: str

class RecoverRequest(BaseModel):
    email: EmailStr

class ResetPasswordRequest(BaseModel):
    email: EmailStr
    code: str
    new_password: str

    @field_validator("new_password")
    @classmethod
    def validate_new_password(cls, v: str) -> str:
        if len(v) < 8:
            raise ValueError("New password must be at least 8 characters")
        return v
    
