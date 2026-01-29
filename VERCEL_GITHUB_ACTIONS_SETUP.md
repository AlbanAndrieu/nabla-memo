# Vercel GitHub Actions Setup Guide

This guide explains how to configure GitHub Actions to automatically deploy your Hugo site to Vercel.

## Prerequisites

1. A Vercel account ([sign up here](https://vercel.com/signup))
2. A Vercel project for your repository
3. GitHub repository with this Hugo site

## Step 1: Create a Vercel Project

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click "Add New" → "Project"
3. Import your GitHub repository
4. Vercel will auto-detect Hugo and configure the build settings
5. Click "Deploy"

## Step 2: Get Your Vercel Credentials

### Get Vercel Token

1. Go to [Vercel Tokens page](https://vercel.com/account/tokens)
2. Click "Create Token"
3. Give it a descriptive name (e.g., "GitHub Actions Deploy")
4. Select an expiration (recommended: "No Expiration" for automation)
5. Click "Create Token"
6. **Copy the token immediately** (you won't see it again)

### Get Organization and Project IDs

#### Option 1: From Vercel CLI

```bash
# Install Vercel CLI
npm install -g vercel

# Login to Vercel
vercel login

# Link your project
cd /path/to/your/repo
vercel link

# Get IDs from .vercel/project.json
cat .vercel/project.json
```

You'll see output like:
```json
{
  "orgId": "team_xxxxxxxxxxxxxxxxxxxxxxxx",
  "projectId": "prj_xxxxxxxxxxxxxxxxxxxxxxxx"
}
```

#### Option 2: From Vercel Dashboard

1. Go to your project in Vercel Dashboard
2. Click "Settings"
3. Under "General", you'll find:
   - **Project ID**: In the URL or under "Project ID" field
   - **Organization ID**: Click your profile → "Settings" → "General" → "Team ID"

## Step 3: Add Secrets to GitHub

1. Go to your GitHub repository
2. Click "Settings" → "Secrets and variables" → "Actions"
3. Click "New repository secret"
4. Add three secrets:

   - **Name**: `VERCEL_TOKEN`
     **Value**: Your Vercel token from Step 2
   
   - **Name**: `VERCEL_ORG_ID`
     **Value**: Your organization/team ID (starts with `team_`)
   
   - **Name**: `VERCEL_PROJECT_ID`
     **Value**: Your project ID (starts with `prj_`)

## Step 4: Verify the Workflow

1. The workflow file is already in `.github/workflows/vercel-deploy.yml`
2. Push a change to trigger the workflow:
   ```bash
   git commit --allow-empty -m "Test Vercel deployment"
   git push
   ```
3. Go to "Actions" tab in your GitHub repository
4. You should see the "Deploy Hugo to Vercel" workflow running

## How It Works

The GitHub Actions workflow:

1. **Triggers** on:
   - Pushes to `master` or `main` branch (production deployment)
   - Pull requests to `master` or `main` (preview deployment)
   - Manual trigger via workflow_dispatch

2. **Steps**:
   - Checkout code with submodules (for Hugo themes)
   - Install Hugo Extended v0.146.0
   - Build the site with `hugo --gc --minify`
   - Deploy to Vercel (production or preview based on event)

3. **Deployments**:
   - **Production**: Direct pushes to main/master branches
   - **Preview**: Pull requests get their own preview URL

## Troubleshooting

### Workflow Fails with "Resource not accessible"

- Check that all three secrets are correctly set in GitHub
- Verify the token hasn't expired
- Ensure the organization and project IDs match your Vercel project

### Theme Not Found Error

- Ensure git submodules are initialized:
  ```bash
  git submodule update --init --recursive
  ```
- The workflow checks out with `submodules: true` to handle this

### Hugo Version Mismatch

- The workflow uses Hugo v0.146.0 (required by PaperMod theme)
- If you need a different version, update `hugo-version` in the workflow file

### Vercel Build Issues

- The `vercel.json` file specifies `HUGO_VERSION: "0.146.0"`
- Vercel auto-detects Hugo via the `hugo.toml` file
- Check Vercel build logs in the Vercel Dashboard for detailed errors

## Deployment URLs

After successful deployment:

- **Production**: Your configured custom domain or `your-project.vercel.app`
- **Preview**: Each PR gets a unique URL like `your-project-git-branch-user.vercel.app`

## Manual Deployment (Alternative)

You can also deploy manually using Vercel CLI:

```bash
# Install Vercel CLI
npm install -g vercel

# Deploy to preview
vercel

# Deploy to production
vercel --prod
```

## Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Hugo Documentation](https://gohugo.io/documentation/)
- [Vercel CLI Reference](https://vercel.com/docs/cli)
