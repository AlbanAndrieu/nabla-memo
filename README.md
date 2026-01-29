# nabla-memo

A modern static website built with Hugo and the PaperMod theme, deployable to Vercel.

## Overview

This repository contains a Hugo static site with automated deployment via GitHub Actions and Vercel.

**Quick Start:**

```bash
# Install dependencies
git clone --recurse-submodules https://github.com/AlbanAndrieu/nabla-memo.git
cd nabla-memo

# Run locally
hugo server -D

# Build for production
hugo --gc --minify
```

📖 **[Full Hugo Documentation](HUGO_DEPLOYMENT.md)**

## Deployment

### Hugo Site Deployment

The repository includes automated deployment via GitHub Actions:

- **Production**: Pushes to `master` or `main` trigger production deployment
- **Preview**: Pull requests trigger preview deployments

**Required Secrets** (for GitHub Actions):
- `VERCEL_TOKEN`: Your Vercel authentication token
- `VERCEL_ORG_ID`: Your Vercel organization ID
- `VERCEL_PROJECT_ID`: Your Vercel project ID

See [HUGO_DEPLOYMENT.md](HUGO_DEPLOYMENT.md) for complete deployment instructions.

## Project Structure

```
.
├── archetypes/          # Hugo content templates
├── content/             # Hugo markdown content
│   ├── _index.md       # Homepage
│   └── about.md        # About page
├── themes/              # Hugo themes
│   └── PaperMod/       # PaperMod theme (submodule)
├── hugo.toml            # Hugo configuration
├── vercel.json          # Vercel deployment configuration
├── HUGO_DEPLOYMENT.md   # Hugo deployment guide
└── .github/
    └── workflows/
        └── vercel-deploy.yml  # GitHub Actions for Vercel deployment
```

### Initialize opencommit and oco

1. Install opencommit:

```bash
npm install -D opencommit
npm install -D @commitlint/cli @commitlint/config-conventional @commitlint/prompt-cli commitizen cz-emoji-conventional

git add .opencommit-commitlint
oco commitlint get

oco config set OCO_PROMPT_MODULE=@commitlint
```
