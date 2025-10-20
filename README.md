# AI Stack - Local AI Engineering Environment

This repository provides a Docker Compose setup for running a modern local AI engineering environment. It focuses on the most in-demand skills: LLMs, RAG, vector databases, embeddings, and experiment tracking.

## 📁 Contents

- `docker-compose.yml`: Docker Compose configuration for AI services
- `.env.example`: Default environment variables (ports, model IDs, tokens)
- `mnt/`: Persistent data directory structure for all services *see [readme](./mnt/README.md)
- `README.md`: This documentation file

## ⚙️ Prerequisites

- Docker 24+ and Docker Compose v2
- Optional GPU: NVIDIA drivers + NVIDIA Container Toolkit (for Ollama GPU acceleration)

## 🏗️ Architecture

The stack provides the following services:

- **Open WebUI**: Chat UI for local models (Ollama)
- **Ollama**: Local LLM runtime (CPU/GPU) for rapid iteration
- **Qdrant**: Vector database for RAG and semantic search
- **Text Embeddings Inference (Hugging Face)**: High-performance embeddings server (e.g., E5/BGE)
- **MLflow**: Experiment tracking and artifact storage
- **Prefect**: Workflow orchestration server (optional, only runs with the 'orchestration' profile)

### Service Dependencies

- Open WebUI depends on Ollama (for local models).
- Other services are independent but commonly used together for RAG/experimentation.

### Data Persistence & Volume Mounts

**Important:** All persistent data is stored under `${HOME}/ai-stack/mnt`.

Example:

```bash
ls "${HOME}/ai-stack/mnt/qdrant"
```

Volume mapping is required for:

- open-webui: Web UI data
- ollama: Downloaded models
- qdrant: Vector database storage
- mlflow: Experiments and artifacts
- hf_cache: Hugging Face cache for embeddings

All containers run within a dedicated `ai-network` Docker bridge network for inter-service communication.

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
    ```

5. **Load a local model in Ollama (first run downloads):**

   ```bash
   docker compose exec ollama ollama pull llama3.1:8b
   docker compose exec ollama ollama run llama3.1:8b "Hello"
   ```

## 🛠️ Customization

- Modify `docker-compose.yml` to adjust service settings, ports, or profiles
- Update `.env` for ports, model IDs, tokens (e.g., `HF_TOKEN`)


## 📊 Service Endpoints & Ports

### Open WebUI
Modern chat UI for interacting with local LLMs (Ollama) and managing conversations. Supports model switching and prompt history. Currently configured in the compose file to talk to Ollama.

**Docs:** [Open WebUI GitHub](https://github.com/open-webui/open-webui)  
**UI:** [http://localhost:3000](http://localhost:3000)

---

### Ollama (Local LLMs)
Local LLM runtime for running, managing, and serving open-source models. Supports both CPU and GPU. 

**Docs** [Ollama Docs](https://ollama.com)  
**API:** [http://localhost:11434](http://localhost:11434)

---

### Qdrant (Vector DB)
High-performance vector database for semantic search, RAG, and similarity queries. Stores embeddings and metadata.

**Docs:** [Qdrant Docs](https://qdrant.tech/documentation)  
**REST API:** [http://localhost:6333](http://localhost:6333)  
**gRPC:** [http://localhost:6334](http://localhost:6334)

---

### Embeddings (Text Embeddings Inference)
Fast, production-grade embeddings server for generating vector representations from text using Hugging Face models.

**Docs:** [Hugging Face TEI](https://github.com/huggingface/text-embeddings-inference)  
**API:** [http://localhost:8989](http://localhost:8989)  
**Model:** Configured via `TEI_MODEL_ID` in `.env` (defaults to `intfloat/e5-base-v2`)

---

### MLflow
Experiment tracking, model registry, and artifact storage for ML workflows. Enables reproducibility and collaboration.  

**Docs:** [MLflow](https://mlflow.org)  
**UI:** [http://localhost:5000](http://localhost:5000)

---

### Prefect
Workflow orchestration and automation for data and ML pipelines. Only runs if you use the 'orchestration' profile.  

**Docs:** [Prefect](https://docs.prefect.io)  
**UI:** [http://localhost:4200](http://localhost:4200)

---

## 🐞 Troubleshooting

- Check container logs:
  ```bash
  docker compose logs -f SERVICE
  ```
- For slow model downloads or gated models, set `HF_TOKEN` in `.env`
- For GPU with Ollama, ensure NVIDIA drivers + NVIDIA Container Toolkit are installed
- Reset stack state:
  ```bash
  docker compose down -v
  rm -rf mnt/*
  ```

## ⚙️ Configuration Insights

### Volume Mount Best Practices
- Data and caches are mounted under `${HOME}/ai-stack/mnt` to persist between runs
- Remove a specific subfolder in `mnt/` to reset just one service

### Startup Dependencies
- Open WebUI waits for Ollama and Open WebUI can be veery slow to start the first time.  *Just wait for it...*
- Health checks are defined for core services (Ollama, Qdrant, TEI, MLflow)

### Port Configuration
- Most endpoints use standard ports; override any port in `.env`

## 🌐 Community & Support

- 🤝 Contributing Guide – see [.github/CONTRIBUTING.md](.github/CONTRIBUTING.md)
- 🤗 Code of Conduct – see [.github/CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md)
- 🆘 Support Guide – see [.github/SUPPORT.md](.github/SUPPORT.md)
- 🔒 Security Policy – see [.github/SECURITY.md](.github/SECURITY.md)

## 📄 License

This project is licensed under the terms of the repository's main LICENSE file.
