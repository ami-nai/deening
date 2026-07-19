from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import auth
from app.core.config import settings

app = FastAPI(
    title="Deening",
    version="1.0.0",
    docs_url="/docs" if settings.ENVIRONMENT == "development" else None,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix="/api/v1")

@app.get("/health")
async def health():
    return {"status": "ok"}