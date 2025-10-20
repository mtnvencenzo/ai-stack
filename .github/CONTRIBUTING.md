# 🤖 Contributing to AI Stack

Thank you for your interest in contributing to the AI Stack project! We welcome contributions that improve this local AI engineering environment (LLMs, RAG, notebooks, experiment tracking) and its documentation and developer experience.

## 📋 Table of Contents

- [Getting Started](#-getting-started)
- [Development Setup](#-development-setup)
- [Contributing Process](#-contributing-process)
- [Code Standards](#-code-standards)
- [Testing](#-testing)
- [Getting Help](#-getting-help)

## 🚀 Getting Started

### 🧰 Prerequisites

Before you begin, ensure you have the following installed:
- Docker and Docker Compose
- Git

### 🗂️ Project Structure

```text
├── docker-compose.yml        # AI engineering services (Ollama, Open WebUI, Qdrant, TEI, MLflow, Prefect, etc.)
├── .env.example              # Default environment variables
├── mnt/                      # Persistent data directories (git-ignored)
│   ├── open-webui/
│   ├── ollama/
│   ├── qdrant/
│   ├── mlflow/
│   └── hf_cache/
└── .github/                  # GitHub workflows and templates
```

## 💻 Development Setup

1. **Fork and Clone the Repository**
   ```bash
   git clone https://github.com/mtnvencenzo/ai-stack.git
   cd ai-stack
   ```

2. **Start the AI Stack Services**
   ```bash
   # Start all services
   docker compose up -d
   
   # Verify services are running
   docker compose ps
   ```

3. **Test the Setup**
   ```bash
   # Open WebUI
   curl -sSf http://localhost:3000 >/dev/null && echo "Open WebUI OK"

   # Ollama tags (after container is up)
   curl -sSf http://localhost:11434/api/tags >/dev/null && echo "Ollama OK"

   # Qdrant readiness
   curl -sSf http://localhost:6333/readyz >/dev/null && echo "Qdrant OK"

   # Embeddings server health (TEI)
   curl -sSf http://localhost:8080/health >/dev/null && echo "TEI OK"

   # MLflow UI
   curl -sSf http://localhost:5000 >/dev/null && echo "MLflow OK"
   ```

## 🔄 Contributing Process

### 1. 📝 Before You Start

- **Check for existing issues** to avoid duplicate work
- **Create or comment on an issue** to discuss your proposed changes
- **Wait for approval** from maintainers before starting work (required for this repository)

### 2. 🛠️ Making Changes

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Make your changes** following our [code standards](#-code-standards)

3. **Test your changes**
   - Validate `docker-compose.yml` starts cleanly
   - Confirm services become healthy and UIs are reachable
   - If you add new services, include healthchecks and docs

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat(api): add new endpoint for ..."
   ```
   
   Use [conventional commit format](https://www.conventionalcommits.org/):
   - `feat:` for new features
   - `fix:` for bug fixes
   - `docs:` for documentation changes
   - `style:` for formatting changes
   - `refactor:` for code refactoring
   - `test:` for adding tests
   - `chore:` for maintenance tasks

### 3. 📬 Submitting Changes

1. **Push your branch**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create a Pull Request**
   - Use our [PR template](pull_request_template.md)
   - Fill out all sections completely
   - Link related issues using `Closes #123` or `Fixes #456`
   - Request review from maintainers

## 📏 Code Standards

### 🐳 Docker & Docker Compose

- Prefer official or well-maintained images (Ollama, Open WebUI, Qdrant, HuggingFace TEI, MLflow, Redis, Jupyter, Prefect, vLLM)
- Follow Docker best practices for service configuration
- Use meaningful container and service names
- Include proper health checks where available
- Document any custom configurations

### 📝 Documentation

- Update documentation when making changes
- Use clear, concise language
- Include code examples for setup instructions
- Update service endpoint information when ports change

### 🗂️ File Organization

- Keep service documentation in the main `README.md` or a future `docs/` folder
- Use consistent naming conventions
- Update `docker-compose.yml` with clear comments

### 🔍 Validation Steps

Before submitting changes:

```bash
# Verify services start correctly
docker compose up -d

# Check service health
docker compose ps

curl -sSf http://localhost:3000 >/dev/null   # Open WebUI
curl -sSf http://localhost:6333/readyz >/dev/null   # Qdrant
curl -sSf http://localhost:8989/health >/dev/null   # TEI
curl -sSf http://localhost:5000 >/dev/null          # MLflow

# Clean up
docker compose down -v
```

### 📏 Test Requirements

- **Service Startup**: All services must start without errors
- **Port Accessibility**: All documented ports must be accessible
- **Data Persistence**: Volume mounts must work correctly
- **Documentation**: Any changes must be documented

## 🆘 Getting Help

### 📡 Communication Channels

- **Issues**: Use GitHub issues for bugs and feature requests
- **Discussions**: Use GitHub Discussions for questions and ideas
- **Email**: Contact maintainers directly for sensitive issues

### 📄 Issue Templates

Use our issue templates for:
- [Task Stories](./ISSUE_TEMPLATE/task-template.md)
- [User Stories](./ISSUE_TEMPLATE/user-story-template.md)

### ❓ Common Questions

**Q: How do I run the AI Stack locally?**
A: Follow the Development Setup above. Use `docker compose up -d`.

**Q: How do I test if the services are working?**
A: Use the health endpoints listed in the Validation Steps.

**Q: Can I contribute without approval?**
A: No, all contributors must be approved by maintainers before making changes.

**Q: How do I add a new AI service?**
A: Add it to `docker-compose.yml` with a clear name, volumes, and healthcheck; document in `README.md`.

## 📜 License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project (see [LICENSE](../LICENSE)).

---

Happy Contributing!  

For any questions about this contributing guide, please open an issue or contact the maintainers.
