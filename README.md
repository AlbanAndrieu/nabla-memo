# nabla-memo

A modern static website built with Hugo and the PaperMod theme, deployable to Vercel and Cloudflare Pages.

## Overview

This repository contains a Hugo static site with automated deployment via GitHub Actions to Vercel and Cloudflare Pages.

**Quick Start:**

```bash
# Install dependencies
git clone --recurse-submodules https://github.com/AlbanAndrieu/nabla-memo.git
cd nabla-memo
npm install

# Run locally with Hugo
hugo server -D

# Or use npm scripts
npm run dev

# Build for production
hugo --gc --minify
# Or
npm run build
```

📖 **[Full Hugo Documentation](HUGO_DEPLOYMENT.md)**

## Deployment Options

This project supports deployment to both **Vercel** and **Cloudflare Pages**:

### Option 1: Vercel Deployment

📖 **[Vercel Deployment Guide](VERCEL_GITHUB_ACTIONS_SETUP.md)**

**Required Secrets:**
- `VERCEL_TOKEN`: Your Vercel authentication token
- `VERCEL_ORG_ID`: Your Vercel organization ID
- `VERCEL_PROJECT_ID`: Your Vercel project ID

### Option 2: Cloudflare Pages Deployment

📖 **[Cloudflare Deployment Guide](CLOUDFLARE_DEPLOYMENT.md)**

**Required Secrets:**
- `CLOUDFLARE_API_TOKEN`: Your Cloudflare API token
- `CLOUDFLARE_ACCOUNT_ID`: Your Cloudflare account ID

## Project Structure

```
.
├── archetypes/          # Hugo content templates
├── content/             # Hugo markdown content
│   ├── _index.md       # Homepage
│   └── about.md        # About page
├── static/              # Static files
│   ├── _headers        # Cloudflare Pages headers
│   └── _redirects      # Cloudflare Pages redirects
├── themes/              # Hugo themes
│   └── PaperMod/       # PaperMod theme (submodule)
├── hugo.toml            # Hugo configuration
├── wrangler.toml        # Cloudflare Wrangler configuration
├── vercel.json          # Vercel deployment configuration
├── package.json         # Node.js dependencies and scripts
├── HUGO_DEPLOYMENT.md   # Hugo deployment guide
├── CLOUDFLARE_DEPLOYMENT.md  # Cloudflare Pages deployment guide
└── .github/
    ├── instructions/    # Copilot best practices
    │   ├── cloudflare-wrangler-best-practices.instructions.md
    │   ├── vercel-deployment.instructions.md
    │   └── hugo-best-practices.instructions.md
    └── workflows/
        ├── vercel-deploy.yml           # Vercel deployment
        └── cloudflare-pages-deploy.yml # Cloudflare Pages deployment
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
