FROM python:3.12-slim

# Dépendances système nécessaires pour curl_cffi
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Installation des dépendances Python
RUN pip install --no-cache-dir requests pyotp curl_cffi

# Copie du script uniquement (sites.json est monté en volume)
COPY autovisit.py .

# Dossier logs (sera persisté via volume)
RUN mkdir -p logs

ENTRYPOINT ["python3", "autovisit.py"]
# Arguments par défaut si aucun passé au run
CMD ["--mp", "--error"]
