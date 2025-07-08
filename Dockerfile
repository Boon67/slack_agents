FROM python:3.11-slim

WORKDIR /app

COPY slackapp.py .
COPY slackapp_agent.py .
COPY requirements.txt .
COPY rsa_private_key.pem .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "slackapp.py"]