import os
import resend
from app.core.config import settings
resend.api_key = settings.RESEND_API_KEY

async def send_recovery_email(to_email: str, code: str) -> None:
    
    await resend.Emails.send_async({
        "from": "Acme <onboarding@resend.dev>",
        "to": ["amishahriar27@gmail.com"],
        "subject": "Your Recovery Code - Deening",
        "html": f"""
                <p>
                {code}
                </p>
                """,
    })

