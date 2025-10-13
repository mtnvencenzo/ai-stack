# AI Stack - Local AI Engineering Environment

This repository provides a Docker Compose setup for running a modern local AI engineering environment. It focuses on the most in-demand skills: LLMs, RAG, vector databases, embeddings, experiment tracking, notebooks, and orchestration.

## 📁 Contents

- docker-compose.yml: Docker Compose configuration for AI services
- .env.example: Default environment variables (ports, model IDs, tokens)
- volumes/: Persistent data directories (ignored from git)
- .github/: Project templates and guidelines (contributing, support, security)
- README.md: This documentation file

## ⚙️ Prerequisites

- Docker 24+ and Docker Compose v2
- Optional GPU: NVIDIA drivers + NVIDIA Container Toolkit (for vLLM and faster Ollama)

## 🏗️ Architecture

The stack provides the following services:

- Open WebUI: Chat UI for local models (Ollama) or OpenAI-compatible servers (vLLM)
- Ollama: Local LLM runtime (CPU/GPU) for rapid iteration
- Qdrant: Vector database for RAG and semantic search
- Text Embeddings Inference (Hugging Face): High-performance embeddings server (e.g., BGE/E5)
- MLflow: Experiment tracking and artifact storage
- Redis: Cache/broker for pipelines and apps
- Jupyter: Notebooks for prototyping and data exploration
- Prefect (optional): Workflow orchestration server
- vLLM (optional, GPU): High-performance OpenAI-compatible LLM inference
- LangFlow (optional): Visual builder for LLM apps and RAG pipelines

### Service Dependencies

- Open WebUI depends on Ollama (for local models). It can also be configured to point at vLLM.
- vLLM is optional and only needed if you want an OpenAI-compatible server with GPU performance.
- Other services are independent but commonly used together for RAG/experimentation.

### Data Persistence

Persistent data is stored under `./volumes`:

- open-webui: Web UI data
- ollama: Downloaded models
- qdrant: Vector database storage
- mlflow: Experiments and artifacts
- redis: Cache data
- jupyter: Notebook settings
- hf_cache: Hugging Face cache for embeddings and vLLM

All containers run within a dedicated `ai` Docker bridge network for inter-service communication.

## 🚀 Setup & Usage

> This setup is designed for local development and learning. Do not use in production environments.

1. Initialize environment variables and start the services

   ```bash
   # cp .env.example .env

   docker compose -p ai-stack -f docker-compose.yml up -d

   # Or if the containers have already been created
   docker compose -p ai-stack -f docker-compose.yml start
   ```

2. **Stop the services:**
    ```bash
    docker compose -p ai-stack -f docker-compose.yml down -v
    ```

3. **Rebuild and restart a specific service:**
    ```bash
    docker compose -p ai-stack -f docker-compose.yml up -d --force-recreate --no-deps --build <service_name>
    ```

4. **Check all services status:**
    ```bash
    docker compose ps

5. Load a local model in Ollama (first run downloads)

   ```bash
   docker compose exec ollama ollama pull llama3.1:8b
   docker compose exec ollama ollama run llama3.1:8b "Hello"
   ```

## 🛠️ Customization

- Modify `docker-compose.yml` to adjust service settings, ports, or profiles
- Update `.env` for ports, model IDs, tokens (e.g., `HF_TOKEN`)
- Mount extra local project folders into the Jupyter container if needed

## 📊 Service Endpoints & Ports

### Open WebUI
- UI: http://localhost:3000
- Notes: Can talk to Ollama and vLLM. Configure OpenAI base URL in settings when using vLLM.

### Ollama (Local LLMs)
- API: http://localhost:11434
- Test: `curl -sSf http://localhost:11434/api/tags | jq .`

### Qdrant (Vector DB)
- REST API: http://localhost:6333
- gRPC: localhost:6334
- Health: `curl -sSf http://localhost:6333/readyz`

### Embeddings (Text Embeddings Inference)
- API: http://localhost:8080
- Health: `curl -sSf http://localhost:8080/health`
- Model: configured via `TEI_MODEL_ID` in `.env` (defaults to `BAAI/bge-small-en-v1.5`)

### MLflow
- UI: http://localhost:5000
- Health: `curl -sSf http://localhost:5000/`

### Redis
- TCP: localhost:6380 (mapped to container 6379)
- Test (from host with redis-cli installed): `redis-cli -p 6380 ping`

### Jupyter
- UI: http://localhost:8888
- Token: `JUPYTER_TOKEN` from `.env` (defaults to `ai-stack`)

### Prefect (optional)
- UI: http://localhost:4200
- Start: `docker compose --profile orchestration up -d prefect`

### vLLM (optional, GPU)
- OpenAI-compatible API: http://localhost:8000
- Health: `curl -sSf http://localhost:8000/health`
- Configure model via `.env` (e.g., `VLLM_MODEL_ID=Qwen/Qwen2.5-7B-Instruct`)

### LangFlow (optional)
- UI: http://localhost:7860
- Start: `docker compose --profile studio up -d langflow`
- Notes: Persisted under `volumes/langflow`; can connect to Ollama (http://ollama:11434), vLLM (http://vllm:8000), Qdrant (http://qdrant:6333), and TEI (http://embeddings:80)

## 🐞 Troubleshooting

- Check container logs:
  ```bash
  docker compose logs -f SERVICE
  ```
- Ensure no port conflicts (Redis defaults to 6380 to avoid common 6379 usage)
- For slow model downloads or gated models, set `HF_TOKEN` in `.env`
- For GPU with vLLM/Ollama, ensure NVIDIA drivers + NVIDIA Container Toolkit are installed
- Reset stack state:
  ```bash
  docker compose down -v
  rm -rf volumes/*
  ```

## ⚙️ Configuration Insights

### Volume Mount Best Practices
- Data and caches are mounted under `./volumes` to persist between runs
- Remove a specific subfolder in `volumes/` to reset just one service

### Startup Dependencies
- Open WebUI waits for Ollama; configure vLLM in WebUI if using the GPU profile
- Health checks are defined for core services (Ollama, Qdrant, TEI, MLflow, vLLM)

### Port Configuration
- Most endpoints use standard ports; Redis maps host 6380 -> container 6379 to avoid local conflicts
- Override any port in `.env`

## 📚 Additional Resources

- Open WebUI: https://github.com/open-webui/open-webui
- Ollama: https://ollama.com
- Qdrant: https://qdrant.tech/documentation
- Hugging Face TEI: https://github.com/huggingface/text-embeddings-inference
- MLflow: https://mlflow.org
- Redis: https://redis.io
- Jupyter: https://jupyter.org
- Prefect: https://docs.prefect.io
- vLLM: https://docs.vllm.ai

## 🌐 Community & Support

- 🤝 Contributing Guide – see [.github/CONTRIBUTING.md](.github/CONTRIBUTING.md)
- 🤗 Code of Conduct – see [.github/CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md)
- 🆘 Support Guide – see [.github/SUPPORT.md](.github/SUPPORT.md)
- 🔒 Security Policy – see [.github/SECURITY.md](.github/SECURITY.md)

## 📄 License

This project is licensed under the terms of the repository's main LICENSE file.
