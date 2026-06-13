---
sidebar_position: 2
---

# Deploy Documentation to Firebase Hosting

This guide describes the full deployment flow for the CondorCode documentation site using Firebase Hosting.

> [!TIP]
> Use **Deployment Routine** section for a recommended sequence of commands for every release.

## Prerequisites

- Node.js 20+ installed
- npm available
- Firebase CLI installed
- Access to the Firebase project used by this repository

## Project Configuration

- Firebase project id: `YOUR-PROJECT-ID`
- Hosting target: `wiki`
- Hosting site: `condorcode-docs`
- Static build output: `wiki/build`

**Root `firebase.json`**
```json
{
  "hosting": [
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

Root .firebaserc
``` json
 {
   "targets": {
     "condorcode-d0e3b": {
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
     "condorcodestaging": {
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

## Full Command List

Run all commands from the **repository root**.

### 1) Build the documentation

```bash
cd wiki
npm run build
cd ..
```

### 2) Install Firebase CLI (if not installed)

```bash
npm install -g firebase-tools
```

### 3) Authenticate in Firebase (if needed)

```bash
firebase login
```

### 4) Verify selected Firebase project

```bash
firebase use
```

If needed, explicitly select the project:

```bash
firebase use YOUR-PROJECT-ID
```

### 5) Deploy docs hosting target

```bash
firebase deploy --only hosting:wiki
```

## Optional Validation Commands

Preview docs locally from production build:

```bash
cd wiki
npm run serve
```

## Recommended Deployment Routine

Use this sequence for every release:

```bash
cd wiki
npm run build
cd ..
firebase deploy --only hosting:wiki
```

## Troubleshooting

- If deploy fails due to auth, run `firebase login` again.
- If target mapping errors appear, verify `.firebaserc` and run `firebase target`.
- If content is outdated after deploy, rebuild docs with `npm run build` before deploying.
