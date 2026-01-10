# AI Stack - Local AI Engineering Environment

This repository provides a Docker Compose setup for running a modern local AI engineering environment. It focuses on the most in-demand skills: LLMs, RAG, vector databases, embeddings, and experiment tracking.

![AI Stack](./assets/ai-stack.drawio.svg)

## 📁 Contents

- `docker-compose.yml`: Docker Compose configuration for AI services
- `.env.example`: Default environment variables (ports, model IDs, tokens)
- `README.md`: This documentation file

## ⚙️ Prerequisites

- Docker 24+ and Docker Compose v2
- Optional GPU: NVIDIA drivers + NVIDIA Container Toolkit (for Ollama GPU acceleration)

## 🏗️ Architecture

The stack provides the following services:

- **Open WebUI**: Chat UI for local models (Ollama)
- **Ollama**: Local LLM runtime (CPU/GPU) for rapid iteration
- **Qdrant**: Vector database for RAG and semantic search
- **Text Embeddings Inference (Hugging Face)**: High-performance embeddings server (e.g., sentence-transformers/all-mpnet-base-v2)
- **Langfuse**: Separate docker compose setup for running Langfuse locally

### Service Dependencies

- Open WebUI depends on Ollama (for local models).
- Other services are independent but commonly used together for RAG/experimentation.

## 🚀 Setup & Usage

> This setup is designed for local development and learning. Do not use in production environments.

1. Initialize environment variables and start the services

   ```bash
   # Build up compose
   docker compose -f docker-compose.yml up -d

   # Or if the containers have already been created
   docker compose -f docker-compose.yml start

   # Optional langfuse observability 
   docker compose -f docker-compose-langfuse.yml up -d
   docker compose -f docker-compose-langfuse.yml start

   ```

2. **Stop the services:**
    ```bash
    # Tear down and remove the volumes
    docker compose -f docker-compose.yml down -v

    # Optional langfuse observability 
    docker compose -f docker-compose-langfuse.yml down -v
    ```

3. **Rebuild and restart a specific service:**
    ```bash
    docker compose -f docker-compose.yml up -d --force-recreate --no-deps --build <service_name>

    # Optional langfuse observability 
    docker compose -f docker-compose-langfuse.yml up -d --force-recreate --no-deps --build <service_name>
    ```

4. **Check all services status:**
    ```bash
    docker compose ps
    ```

5. **Load a local model in Ollama (first run downloads):**

   ```bash
   docker compose exec ollama ollama pull qwen3:8b
   docker compose exec ollama ollama run qwen3:8b "Hello"
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
**GPU Support:** [Setup with docker](https://github.com/mtnvencenzo/bash/blob/main/docker/gpu.sh)

#### Host machine install
```bash
# to install ollama on the host machine and make it available from
# docker containers (via host.docker.internal)
curl -fsSL https://ollama.com/install.sh | sh

# By default, Ollama only listens on 127.0.0.1 (localhost) for security reasons. You need to create a systemd override file to change this behavior so that it runs on a non-loopback address so it can be accessible from containers running on non-host networks
sudo systemctl edit ollama.service

# Add the following lines to the file to set the OLLAMA_HOST variable to 0.0.0.0
[Service]
Environment="OLLAMA_HOST=0.0.0.0"

# Restart and verify the service
sudo systemctl daemon-reload
sudo systemctl restart ollama.service

# Verify - You should see output indicating that it is listening on *:11434 or 0.0.0.0:11434, instead of 127.0.0.1:11434
sudo ss -antp | grep 11434
```

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
**Model:** Configured via `TEI_MODEL_ID` in `.env` (defaults to `sentence-transformers/all-mpnet-base-v2`)

---


## ⚙️ Configuration Insights

### Startup Dependencies
- Open WebUI waits for Ollama and Open WebUI can be veery slow to start the first time.  *Just wait for it...*
- Health checks are defined for core services (Ollama, Qdrant, TEI)

### Port Configuration
- Most endpoints use standard ports; override any port in `.env`

## 🌐 Community & Support

- 🤝 Contributing Guide – see [.github/CONTRIBUTING.md](.github/CONTRIBUTING.md)
- 🤗 Code of Conduct – see [.github/CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md)
- 🆘 Support Guide – see [.github/SUPPORT.md](.github/SUPPORT.md)
- 🔒 Security Policy – see [.github/SECURITY.md](.github/SECURITY.md)

## 📄 License

This project is licensed under the terms of the repository's main LICENSE file.
