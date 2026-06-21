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

## ⏰ PR Review Schedule

Pull requests are reviewed on a weekly schedule. This helps maintainers balance open source work with other responsibilities.

| Review Window | Timezone |
|---------------|----------|
| **Friday – Sunday** | Europe/Kiev (UTC+2/+3) |

**What this means:**
- **Initial review**: Your PR will be reviewed during the next Friday–Sunday window after submission
- **Follow-up reviews**: If changes are requested, the next review happens in the following window
- **You can update anytime**: Feel free to push updates at any time — reviews only happen during the scheduled window
- **Outside the window**: We may occasionally review outside this schedule, but there are no guarantees

**Workflow for updates:**
1. Maintainer reviews and requests changes
2. You address feedback and push updates
3. PR waits for the next review window
4. Maintainer re-reviews in the next Friday–Sunday window

This keeps the process predictable and respects everyone's time. Thank you for your patience! 🙏

---

## 📋 Pull Request Process

1. Update documentation if needed
2. Ensure all checks pass (CI will run automatically)
3. Fill out the PR template
4. Request review from maintainers
5. Address review feedback
6. **We squash merge**: All commits in your PR will be squashed into a single commit when merged. No need to manually squash — just push your changes as needed.
7. **Follow Conventional Commits**: All commits and your PR title must follow the [Conventional Commits](https://www.conventionalcommits.org/) format: `type(scope): description`. See commit guidelines above for details.

---

## 🤖 Alfred — Our AI Assistant

Meet **Alfred** — the personal AI assistant of Oleh Savenko ([@savavskoy](https://github.com/savavskoy)). He is your helpful colleague who never sleeps and genuinely cares about code quality.

### What Alfred Helps With

**Keeping Code Clean**
- Reviews your pull requests with fresh eyes
- Suggests improvements you might have missed
- Makes sure we're all following the same conventions

**Making Docs Better**
- Keeps documentation up to date so you don't have to hunt for answers
- Creates templates and workflows to save everyone time
- Writes clear guides for new contributors

**Running the Repo Smoothly**
- Creates issues and PRs when needed
- Keeps an eye on contributor activity
- Automates the boring stuff so humans can focus on what matters

**Welcoming Contributors**
- Greets new PRs with helpful info
- Provides checklists so nothing gets forgotten
- Makes sure everyone feels supported

### The Important Stuff

- Alfred's review is **just a suggestion** — you don't have to fix everything
- Only **code owners** (human maintainers) can request changes
- Think of Alfred as a second pair of eyes, not a gatekeeper
- Final decisions always come from the team, never from AI

### Why We Have Alfred

He helps us maintain quality without getting in the way. More eyes on the code means fewer bugs slip through, and automating routine tasks means humans have more time for the creative work.

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