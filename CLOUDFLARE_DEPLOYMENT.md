# Cloudflare Pages Deployment Setup

This document describes how to deploy the Nabla Memo Hugo site to Cloudflare Pages.

## Overview

Cloudflare Pages is a JAMstack platform for deploying static sites with:
- Global CDN with 300+ edge locations
- Automatic HTTPS and SSL certificates
- Unlimited bandwidth (free tier)
- Preview deployments for pull requests
- Built-in DDoS protection
- Integration with Cloudflare Workers for edge computing

## Prerequisites

1. **Cloudflare Account**: Sign up at [cloudflare.com](https://www.cloudflare.com/)
2. **Cloudflare Pages Project**: Create a new Pages project in the Cloudflare dashboard
3. **API Token**: Generate an API token with the following permissions:
   - Account > Cloudflare Pages > Edit
4. **Account ID**: Found in your Cloudflare dashboard URL or account settings

## Configuration Files

### 1. `wrangler.toml`

The main configuration file for Cloudflare Wrangler CLI:

```toml
name = "nabla-memo"
compatibility_date = "2024-01-29"
pages_build_output_dir = "public"

[build]
command = "hugo --gc --minify"

[build.environment]
HUGO_VERSION = "0.146.0"
HUGO_EXTENDED = "true"
```

### 2. `static/_headers`

Security and caching headers for Cloudflare Pages:
- Security headers (X-Frame-Options, CSP, etc.)
- Cache-Control headers for static assets
- Automatically deployed with the site

### 3. `static/_redirects`

URL redirects and rewrites:
- 301/302 redirects
- Domain redirects
- SPA fallback routing (if needed)

## GitHub Actions Workflow

The `.github/workflows/cloudflare-pages-deploy.yml` workflow automates deployment:

### Production Deployment
Triggered on push to `main` or `master` branch:
```yaml
- Checkout code with submodules
- Setup Hugo (version 0.146.0 Extended)
- Build site with Hugo
- Deploy to Cloudflare Pages production
```

### Preview Deployment
Triggered on pull requests:
```yaml
- Same build steps as production
- Deploy to Cloudflare Pages preview environment
- Post preview URL as PR comment
```

## Setup Instructions

### Step 1: Create Cloudflare Pages Project

1. Log in to [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. Go to **Workers & Pages** > **Pages**
3. Click **Create a project**
4. Choose **Connect to Git** (optional) or use **Direct Upload**
5. Name your project: `nabla-memo`
6. Configure build settings:
   - **Build command**: `hugo --gc --minify`
   - **Build output directory**: `public`
   - **Root directory**: `/` (leave blank)

### Step 2: Generate Cloudflare API Token

1. Go to **My Profile** > **API Tokens**
2. Click **Create Token**
3. Use the **Edit Cloudflare Workers** template or create custom token
4. Permissions needed:
   - **Account** > **Cloudflare Pages** > **Edit**
5. Copy the generated token (you won't see it again!)

### Step 3: Configure GitHub Secrets

Add the following secrets to your GitHub repository:

1. Go to **Settings** > **Secrets and variables** > **Actions**
2. Click **New repository secret**
3. Add these secrets:

   - **Name**: `CLOUDFLARE_API_TOKEN`
     - **Value**: Your Cloudflare API token from Step 2

   - **Name**: `CLOUDFLARE_ACCOUNT_ID`
     - **Value**: Your Cloudflare account ID (found in dashboard URL or settings)

### Step 4: Enable Workflow

1. The workflow file is already committed: `.github/workflows/cloudflare-pages-deploy.yml`
2. Push code to `main`/`master` branch to trigger production deployment
3. Create a pull request to trigger preview deployment

## Manual Deployment with Wrangler CLI

### Install Wrangler

```bash
npm install -g wrangler
# or
npm install
```

### Authenticate

```bash
wrangler login
```

### Deploy Manually

```bash
# Build the Hugo site
hugo --gc --minify

# Deploy to Cloudflare Pages
wrangler pages deploy public --project-name=nabla-memo

# Or use npm script
npm run build
npm run cf:deploy
```

### Local Development with Wrangler

```bash
# Build the site
hugo --gc --minify

# Serve with Wrangler (simulates Cloudflare Pages environment)
wrangler pages dev public

# Or use npm script
npm run cf:dev
```

## Environment Variables

### Build-Time Variables

Set in `wrangler.toml` under `[build.environment]`:
```toml
HUGO_VERSION = "0.146.0"
HUGO_EXTENDED = "true"
```

### Runtime Variables (if using Workers)

Set in `wrangler.toml` under `[vars]`:
```toml
[vars]
ENVIRONMENT = "production"
```

Or use Wrangler secrets for sensitive data:
```bash
wrangler secret put API_KEY
```

## Custom Domain Setup

1. Go to your Cloudflare Pages project
2. Click **Custom domains**
3. Click **Set up a custom domain**
4. Enter your domain name
5. Cloudflare will automatically configure DNS if domain is on Cloudflare
6. SSL certificate is automatically provisioned

## Deployment URLs

- **Production**: `https://nabla-memo.pages.dev`
- **Preview**: `https://<branch>.<project>.pages.dev`
- **Custom Domain**: Configure in Cloudflare dashboard

## Monitoring and Logs

### View Deployment History
1. Go to Cloudflare Dashboard > Workers & Pages > nabla-memo
2. Click **Deployments** tab
3. View build logs, deployment status, and rollback if needed

### Real-Time Logs (if using Workers)
```bash
wrangler tail
```

### Analytics
- Go to your Pages project > **Analytics**
- View page views, bandwidth, and performance metrics
- Enable Cloudflare Web Analytics for detailed insights

## Rollback

To rollback to a previous deployment:
1. Go to **Deployments** tab in Cloudflare dashboard
2. Find the stable deployment
3. Click **···** > **Rollback to this deployment**

## Troubleshooting

### Build Fails
- Check Hugo version matches in workflow and `wrangler.toml`
- Verify build command is correct
- Check submodules are properly initialized
- Review build logs in Cloudflare dashboard

### Deployment Fails
- Verify `CLOUDFLARE_API_TOKEN` has correct permissions
- Check `CLOUDFLARE_ACCOUNT_ID` is correct
- Ensure project name matches exactly
- Review GitHub Actions logs

### Preview URL Not Posted
- Verify `GITHUB_TOKEN` permissions in workflow
- Check `pull-requests: write` permission is set
- Review Actions logs for errors

### Site Not Loading
- Check if deployment succeeded in dashboard
- Verify output directory is `public`
- Check browser console for errors
- Review `_headers` file for CSP issues

## Comparison: Vercel vs. Cloudflare Pages

| Feature | Vercel | Cloudflare Pages |
|---------|--------|------------------|
| Global CDN | ✅ Yes | ✅ Yes (300+ locations) |
| Free Tier Bandwidth | 100 GB/month | ✅ Unlimited |
| Build Minutes | 6000 min/month | 500 builds/month |
| Preview Deployments | ✅ Yes | ✅ Yes |
| Custom Domains | ✅ Yes | ✅ Yes |
| Edge Functions | ✅ Yes | ✅ Yes (Workers) |
| DDoS Protection | Basic | ✅ Advanced |
| Analytics | ✅ Yes (paid) | ✅ Yes (free) |

Both platforms are excellent choices. This repository supports both!

## Additional Resources

- [Cloudflare Pages Documentation](https://developers.cloudflare.com/pages/)
- [Wrangler CLI Documentation](https://developers.cloudflare.com/workers/wrangler/)
- [Hugo on Cloudflare Pages Guide](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/)
- [Cloudflare Pages Action](https://github.com/cloudflare/pages-action)
- [Cloudflare Workers Documentation](https://developers.cloudflare.com/workers/)

## Support

For issues or questions:
- GitHub Issues: [AlbanAndrieu/nabla-memo/issues](https://github.com/AlbanAndrieu/nabla-memo/issues)
- Cloudflare Community: [community.cloudflare.com](https://community.cloudflare.com/)
- Cloudflare Support: Available for paid plans

## Next Steps

1. ✅ Configure GitHub Secrets
2. ✅ Push to main branch to test deployment
3. ✅ Create a PR to test preview deployment
4. ⏳ Configure custom domain (optional)
5. ⏳ Enable Web Analytics (optional)
6. ⏳ Set up deployment notifications (optional)
