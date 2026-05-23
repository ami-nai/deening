from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    DATABASE_URL: str
    REDIS_URL: str
    SECRET_KEY: str
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 10080
    REFRESH_TOKEN_EXPIRE_DAYS: int = 90
    ENVIRONMENT: str = "development"

    #Resend email
    RESEND_API_KEY: str
    EMAIL_FROM: str = "amishahriar27@gmail.com"

    #Recovery code expiry
    RECOVERY_CODE_EXPIRE_MINUTES: int = 15

    class Config: 
        env_file = ".env"

settings = Settings()
