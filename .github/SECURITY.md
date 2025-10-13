# 🔒 Security Policy

## 🛡️ Supported Versions

We release patches for security vulnerabilities. Which versions are eligible for receiving such patches depends on the CVSS v3.0 Rating:

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## 🚨 Reporting a Vulnerability

The AI Stack team takes security bugs seriously. We appreciate your efforts to responsibly disclose your findings, and will make every effort to acknowledge your contributions.

### Where to Report

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them to the maintainer [@mtnvencenzo](https://github.com/mtnvencenzo)

### What to Include

To help us better understand the nature and scope of the possible issue, please include as much of the following information as possible:

- 🎯 **Type of issue** (e.g., container escape, exposed credentials, insecure defaults, etc.)
- 📁 **Full paths of source file(s)** related to the manifestation of the issue
- 📍 **Location of the affected source code** (tag/branch/commit or direct URL)
- ⚙️ **Special configuration** required to reproduce the issue
- 🔄 **Step-by-step instructions** to reproduce the issue
- 💥 **Proof-of-concept or exploit code** (if possible)
- 🎯 **Impact of the issue**, including how an attacker might exploit the issue

## 📞 Response Timeline

- **Initial Response**: Within 48 hours of receiving your report
- **Status Update**: Within 7 days with a more detailed response
- **Resolution**: We aim to resolve critical issues within 30 days

## 🏆 Recognition

We believe in acknowledging security researchers who help improve our security:

- 📝 **Security Advisory**: We will credit you in the security advisory (unless you prefer to remain anonymous)
- 🎖️ **Hall of Fame**: Recognition in our security contributors list

## 🔐 Security Best Practices

### For Users

- 🔄 **Keep Updated**: Always use the latest version of the Docker images
- 🔑 **Network Security**: Run containers on isolated networks when possible
- 🌐 **Local Use Only**: These emulators are designed for local development only
- 📱 **Environment Security**: Keep your Docker environment and host system updated

### For Developers

- 🛡️ **Container Security**: Prefer official or well-maintained images (Ollama, Open WebUI, Qdrant, Hugging Face TEI, MLflow, Redis, Jupyter, Prefect, vLLM)
- 🔒 **Network Isolation**: Configure proper network segmentation; expose only necessary ports
- 🔑 **Secrets Management**: Keep tokens like `HF_TOKEN` out of git; use `.env` files or secret managers
- 📊 **Monitoring**: Monitor container logs for unusual activity
- 🔄 **Updates**: Keep Docker images updated via Dependabot

## 📚 Additional Resources

- [Docker Security Best Practices](https://docs.docker.com/develop/security-best-practices/)
- [OWASP Docker Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)
 
## 📋 Security Checklist

Our security measures include:

- ✅ **Trusted Images**: Using official or well-maintained images
- ✅ **Network Isolation**: Containers run on isolated Docker networks
- ✅ **Local Development**: Services designed for local development environments only
- ✅ **Dependency Scanning**: Automated via Dependabot
- ✅ **Regular Updates**: Keeping emulator images current
- ✅ **Documentation**: Clear security guidelines and best practices

---

**Thank you for helping keep AI Stack and our users safe! 🤖**