---
sidebar_position: 1
---

# SDD Documentation Overview

This section explains how our Software Design Documentation (SDD) is organized and maintained for the CondorCode team.

## What This Documentation Is

Our SDD docs are the single source of truth for:

- architecture decisions
- implementation guidelines
- team conventions
- onboarding and maintenance knowledge

## For Newcomers and Juniors

Understanding the **condor_code_monorepo** is part of onboarding. Before contributing, read [Working with the Monorepo](../codebase/conventions/working-with-monorepo.md). It explains the workspace structure, Melos commands, code generation, and common pitfalls. This guide is required reading for all new team members.

## Technology Stack Used

This documentation website is built and hosted with:

- **Docusaurus 3.x** for docs structure, routing, sidebar generation, and local authoring workflow
- **Markdown/MDX** for writing documentation pages
- **Firebase Hosting** for production deployment and public access

## How to Add a New Document

1. Create a new `.md` or `.mdx` file in `wiki/docs/` (or a relevant subfolder).
2. Add front matter when needed (for example `sidebar_position`, `title`, or `slug`).
3. Use clear headings and concise content focused on one topic.
4. Add links to related docs to keep navigation easy.
5. Save and run the local docs server to verify rendering and sidebar placement.

Example front matter:

```md
---
sidebar_position: 4
---
```

## How to Verify Your Result

Before running the local docs server for the first time, make sure the Docusaurus CLI is installed globally:

```bash
npm install -g docusaurus
```

Run from the `wiki/` directory:

```bash
npm start
```

Then verify:

- the document appears in the expected sidebar location
- all internal links work
- Markdown/MDX formatting is correct
- the page displays correctly in dark theme

You can also run a production build check:

```bash
npm run build
```

## Useful Guides
- [Create a Document](./tutorial-basics/create-a-document.md)
- [Markdown Features](./tutorial-basics/markdown-features.mdx)
- [Manage Docs Versions](./tutorial-extras/manage-docs-versions.md)

Deployment guide:
- [Deploy Documentation to Firebase Hosting](./deploy-to-firebase-hosting.md)
