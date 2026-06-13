---
sidebar_position: 3
title: Deployment Guide
---

# Deployment Guide

This guide covers how to manually deploy the CondorCode Flutter web apps to **Firebase Hosting** from your local machine. Use it for both **staging** (QA/pre-release) and **production** (live) environments.

> [!TIP]
> Prefer the GitHub Actions workflows (see [CI/CD](ci-cd.md)) for repeatable, team-safe deployments. This guide is for ad-hoc local deploys, hotfixes, or first-time environment setup.

---

## Prerequisites

- **Flutter 3.35.0** installed (use FVM — see [FVM](conventions/fvm.md))
- **Node.js 20+** and `npm`
- **Firebase CLI** installed globally:
  ```bash
  npm install -g firebase-tools
  ```
- You are **logged in** to Firebase and have access to the target project:
  ```bash
  firebase login
  ```
- The workspace is **bootstrapped** and code is **generated**:
  ```bash
  fvm dart run melos bootstrap
  fvm dart run melos run generate
  ```

---

## Environment Overview

Both apps use a single entry point (`lib/main.dart`) and are configured via `--dart-define` flags.

| Variable | Staging value | Production value |
|----------|---------------|------------------|
| `BUILD_TYPE` | `staging` | `prod` |
| `DATA_SOURCE` | `remote` | `remote` |

- **`BUILD_TYPE`** selects the Firebase project and environment-specific configuration.
- **`DATA_SOURCE=remote`** connects the app to Firebase (as opposed to local mock data).

---

## Firebase Hosting Setup per App

### 1. Create firebase.json file in the root directory

```json
{
  "hosting": [
    {
      "target": "platform",
      "public": "apps/condor_code_app/build/web",
      "ignore": [
        "firebase.json",
        "**/.*",
        "**/node_modules/**"
      ],
      "rewrites": [
        {
          "source": "**",
          "destination": "/index.html"
        }
      ]
    },
    {
      "target": "admin",
      "public": "apps/condor_code_admin_app/build/web",
      "ignore": [
        "firebase.json",
        "**/.*",
        "**/node_modules/**"
      ],
      "rewrites": [
        {
          "source": "**",
          "destination": "/index.html"
        }
      ]
    },
    {
      "target": "wiki",
      "public": "wiki/build",
      "ignore": [
        "firebase.json",
        "**/.*",
        "**/node_modules/**"
      ]
    }
  ]
}
```

### 2. Create .firebaserc with project aliases in the root directory
In the app directory (e.g. `apps/condor_code_app`), create a `.firebaserc` file with the following content:
Change the `PRODUCTION-PROJECT-ID` and `STAGING-PROJECT-ID` to your actual Firebase project IDs.

```json
 {
  "targets": {
    "PRODUCTION-PROJECT-ID": {
      "hosting": {
        "wiki": [
          "condorcode-docs"
        ],
        "platform": [
          "condorcode"
        ],
        "admin": [
          "condorcode-admin"
        ]
      }
    },
    "STAGING-PROJECT-ID": {
      "hosting": {
        "platform": [
          "condorcodestaging"
        ],
        "admin": [
          "condorcodestaging-admin"
        ]
      }
    }
  }
}
```

## Deployment

### 1. Build the staging web app

From the workspace root:

```bash
cd apps/condor_code_app
fvm flutter build web -t lib/main.dart --dart-define=BUILD_TYPE=staging --dart-define=DATA_SOURCE=remote
```

```bash
cd apps/condor_admin_code_app
fvm flutter build web -t lib/main.dart --dart-define=BUILD_TYPE=staging --dart-define=DATA_SOURCE=remote
```

> Output is written to `apps/condor_code_app/build/web` (the same for admin app).


### 3. Deploy to Firebase Hosting (staging)
From the root directory, deploy the staging app:

```bash
firebase use YOUR-STAGING-PROJECT-ID or YOUR-PRODUCTION-PROJECT-ID
firebase deploy --only hosting:platform
firebase deploy --only hosting:admin
```

### 3. Verify

Open the Hosting URL printed in the deploy output (e.g. `https://YOUR_STAGING_PROJECT_ID.web.app`).

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `firebase: command not found` | Run `npm install -g firebase-tools` |
| `Error: No authorized domains` | Ensure you ran `firebase login` and have access to the project |
| 404 on deep links (e.g. `/lesson/123`) | Verify `firebase.json` has the `"rewrites"` rule to `/index.html` |
| Wrong Firebase project used | Use `firebase use PROJECT_ID` or always pass `--project PROJECT_ID` |
| Build fails after package changes | Run `fvm dart run melos bootstrap` and `fvm dart run melos run generate` again |
| Stale build output | Run `fvm flutter clean` in the app directory, then rebuild |

---

## Related

- [CI/CD](ci-cd.md) — Automated GitHub Actions pipelines
- [Working with the Monorepo](conventions/working-with-monorepo.md) — Bootstrap, generate, and pre-push workflow
- [FVM](conventions/fvm.md) — Flutter version management
