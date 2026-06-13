# Contributing to CondorCode

Welcome, Condor Coder! 🦅

Thank you for your interest in contributing to CondorCode! This document outlines the rules, conventions, and workflow for all contributors.

> 🚀 **New to the codebase?**  
> Before you dive in, follow the [Onboarding Guide](wiki/docs/onboarding/onboarding_rule.md) for a step-by-step walkthrough: how to clone, set up Flutter, run the app, and open your first PR.

---

## 🎯 Code of Conduct

- Be respectful and constructive
- Focus on what is best for the community and learners
- Show empathy towards other contributors

---

## 🍴 Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
```bash
git clone https://github.com/YOUR_USERNAME/condor_code.git
```

3. Add upstream remote:
```bash
git remote add upstream https://github.com/CondorCodeOrg/condor_code.git
```

---

## 🌿 Branch Strategy

All branches must start with either `feature/` or `fix/`.

| Branch | Purpose |
|--------|---------|
| `main` | Production-ready code |
| `develop` | Integration branch — open PRs here |
| `feature/*` | New features |
| `fix/*` | Bug fixes |

Create branches from `develop`:
```bash
git checkout develop
git pull upstream develop
git checkout -b feature/your-feature-name
```

---

## 📝 Commit Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat` — New feature
- `fix` — Bug fix

Examples:
```
feat(cc-app): add progress tracking for lessons
fix(cc-admin): resolve course deletion bug
```

---

## 🧪 Before Submitting

Run the pre-push checks:

```bash
fvm dart run melos run prepush
```

This will:
- Generate code with build_runner
- Format all files
- Run static analysis

If it passes locally, CI will pass too. For a full explanation of each command, see the [Onboarding Guide](wiki/docs/onboarding/onboarding_rule.md).

---

## 📋 Pull Request Process

1. Update documentation if needed
2. Ensure all checks pass (CI will run automatically)
3. Fill out the PR template
4. Request review from maintainers
5. Address review feedback

---

## 🔒 Security

- **Never commit Firebase configuration files**
- **Never commit API keys or secrets**
- Use `.example` files as templates
- Report security issues privately to maintainers

---

## 💬 Questions?

- Open a [GitHub Discussion](https://github.com/CondorCodeOrg/condor_code/discussions)
- Or ask in the team communication channel

---

## 🙏 Attribution

Contributors will be listed in the project README, releases and YouTube channel.

Thank you for helping learners around the world! 🎉