# 🛠️ Contributing to Platform Ops

Thank you for your interest in contributing to the Platform Ops project! We welcome contributions that improve these Docker Compose stacks for local development environments and their documentation and developer experience.

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
├── stacks/                   # Docker Compose stacks
│   ├── ai-stack/             # AI engineering services
│   ├── azure-stack/          # Azure service emulators
│   ├── kafka-stack/          # Kafka environment
│   └── ...                   # Other stacks
├── dev-certs/                # Development SSL certificates
├── docker-setup/             # Docker management scripts
├── INSTALL_K8S.md            # Kubernetes installation guide
└── .github/                  # GitHub workflows and templates
```

## 💻 Development Setup

1. **Fork and Clone the Repository**
   ```bash
   git clone https://github.com/mtnvencenzo/platform-ops.git
   cd platform-ops
   ```

2. **Start a Stack**
   ```bash
   # Navigate to a stack directory
   cd stacks/ai-stack
   
   # Start services
   docker compose up -d
   
   # Verify services are running
   docker compose ps
   ```

3. **Test the Setup**
   - Follow the README in each stack directory for specific health checks and verification steps

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

- Prefer official or well-maintained images
- Follow Docker best practices for service configuration
- Use meaningful container and service names
- Include proper health checks where available
- Document any custom configurations

### 📝 Documentation

- Update documentation when making changes
- Use clear, concise language
- Include code examples for setup instructions
- Update service endpoint information when ports change


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

**Q: How do I run a stack locally?**
A: Navigate to the stack directory and use `docker compose up -d`.

**Q: How do I test if the services are working?**
A: Check the README in each stack for specific health endpoints and verification steps.

**Q: Can I contribute without approval?**
A: No, all contributors must be approved by maintainers before making changes.

**Q: How do I add a new service to a stack?**
A: Add it to the stack's `docker-compose.yml` with a clear name, volumes, and healthcheck; document in the stack's `README.md`.

## 📜 License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project (see [LICENSE](../LICENSE)).

---

Happy Contributing!  

For any questions about this contributing guide, please open an issue or contact the maintainers.
