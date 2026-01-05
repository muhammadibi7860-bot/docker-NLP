FROM python:3.12-slim

# System deps (compiler + SSL certs)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc g++ \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# spaCy model compatible with spaCy 3.7.x
RUN pip install --no-cache-dir \
  https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.7.1/en_core_web_sm-3.7.1-py3-none-any.whl

COPY *.py /app/
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
