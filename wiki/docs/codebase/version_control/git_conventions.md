# 📜 Git Conventions

This document covers branch naming and commit message conventions for the CondorCode monorepo.

---

## 🌿 Branch Naming

All branches must start with one of the following prefixes:

`feature/` for new features or enhancements

`fix/` for bug fixes

### Examples

`feature/add-user-authentication`

`fix/login-crash-on-ios`

---

## 📝 Commit Message Conventions

To maintain order and enable automation within our Flutter monorepo, we strictly follow the **Conventional Commits** specification. This allows **Melos** to automate versioning and changelog generation.

## 🏗 Structure

Every commit message must follow this format:

`type(scope): description`

---

## 🛠 1. Types

The **type** describes *what* was done:

* **feat**: A new feature for the user.
* **fix**: A bug fix.
* **docs**: Documentation only changes (README, code comments).
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons).
* **refactor**: A code change that neither fixes a bug nor adds a feature.
* **test**: Adding missing tests or correcting existing tests.
* **ci**: Changes to our CI configuration files and scripts (GitHub Actions, Melos).
* **chore**: Routine tasks like updating dependencies or project metadata.
* **build**: Changes that affect the build system or external dependencies.

### Branch Naming Requirement

All branches must start with `feature/` or `fix/`.

Examples:

`feature/add-user-authentication`

`fix/login-crash-on-ios`

When creating a branch, the commit type and branch prefix should align: use `feat` commits in `feature/` branches and `fix` commits in `fix/` branches.

---

## 🎯 2. Scopes

The **scope** describes *where* the change happened. Use the following designated scopes:

| Scope          | Description                                            |
|----------------|--------------------------------------------------------|
| `repo`         | Global workspace changes (Melos config, root pubspec). |
| `ci`           | Global CI/CD workflows (GitHub Actions).               |
| `cc-app`       | Ios, Android and Web CondorCode apps.                  |
| `cc-admin-app` | The admin dashboard app.                               |
| `ui-kit`       | Shared UI components and theme.                        |
| `models`       | Shared data models and serialization.                  |
| `api-client`   | Shared networking and API logic.                       |
| `shared-utils` | Shared helper functions and extensions.                |

---

## 📝 3. Examples

### Global / CI

> `ci(repo): setup global github actions workflow`
> `chore(repo): update melos version`

### App Specific

> `feat(cc-app): integrate youtube comments player`
> `fix(admin-app): fix table overflow on mobile view`

### Shared Packages

> `refactor(ui-kit): migrate shared buttons to material 3`
> `test(api-client): add unit tests for glucose data fetcher`

### Docs

> `docs(repo): add conventional commits documentation`

---

## 🚨 4. Critical Rules

1. **Use lowercase:** The description and scope should be in lowercase.
* ✅ `feat(ui-kit): add primary button`
* ❌ `feat(UI-Kit): Add Primary Button`


1. **No period at the end:** Keep it a concise statement.
2. **Imperative mood:** Use "add" instead of "added", "fix" instead of "fixed".
3. **Breaking Changes:** If a change breaks backward compatibility, add an `!` after the type:
   `feat(api-client)!: change base authentication url`

---

## 💡 Why we do this

By following these rules, **Melos** can:

1. Automatically determine the next version number (Semantic Versioning).
2. Generate a clean `CHANGELOG.md` for every release.
3. Allow developers to quickly filter the git history.

---

Everything is set, Sir. Your team now has no excuses for messy logs.

**Would you like me to help you set up a `commitlint` configuration to automatically enforce these rules during every git commit?**