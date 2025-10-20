FROM python:3.11-slim

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update \ 
    && apt-get install -y --no-install-recommends \
       build-essential \
       gcc \
       curl \ 
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip setuptools wheel \
    && pip install "mlflow==2.16.2"

EXPOSE 5000

# Default MLflow config (overridable by environment)
ENV MLFLOW_BACKEND_STORE_URI=sqlite:////mlflow/mlruns.db \
    MLFLOW_ARTIFACT_ROOT=/mlflow/artifacts \
    MLFLOW_HOST=0.0.0.0 \
    MLFLOW_PORT=5000

VOLUME ["/mlflow"]
WORKDIR /mlflow

CMD ["mlflow", "server", \
     "--host", "0.0.0.0", \
     "--port", "5000", \
     "--backend-store-uri", "sqlite:////mlflow/mlruns.db", \
     "--artifacts-destination", "/mlflow/artifacts"]
