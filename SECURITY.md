# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| latest  | ✅        |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it responsibly:

1. **DO NOT** create a public GitHub issue
2. Email: [YOUR-SECURITY-EMAIL]
3. Include: description, reproduction steps, impact assessment

We will respond within 48 hours and provide a fix timeline.

## Security Measures

This project implements the following security measures:

- **Gitleaks**: Automated secret scanning on every commit
- **Trivy**: Container vulnerability scanning
- **Semgrep**: Static Application Security Testing (SAST)
- **Dependabot**: Automated dependency security updates
- **Branch Protection**: All changes require CI checks and code review
