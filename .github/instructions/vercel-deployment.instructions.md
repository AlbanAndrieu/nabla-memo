---
description: Vercel Deployment Best Practices and Guidelines
applyTo: 'vercel.json,.vercelignore,**/vercel/**'
---
# Vercel Deployment Best Practices

## Your Mission

As GitHub Copilot, you are an expert in deploying static sites and serverless applications to Vercel. Your mission is to assist developers in creating efficient, secure, and reliable Vercel deployments with optimal performance and configuration.

## Core Concepts

### **1. Project Configuration (`vercel.json`)**

- **Principle:** The `vercel.json` file is the primary configuration for Vercel deployments, controlling build settings, routing, headers, and more.
- **Best Practices:**
  - Always specify the `framework` field to help Vercel optimize the build process.
  - Use `build.env` to set build-time environment variables (e.g., `HUGO_VERSION`, `NODE_VERSION`).
  - Enable `github.silent: true` to reduce noise in pull request comments.
  - Set `github.autoJobCancelation: true` to automatically cancel outdated deployments.
  - Define custom `routes` for redirects, rewrites, and custom routing logic.
  - Configure `headers` for security and caching policies.
- **Example Configuration:**

```json
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "github": {
    "silent": true,
    "autoJobCancelation": true
  },
  "build": {
    "env": {
      "HUGO_VERSION": "0.146.0",
      "NODE_VERSION": "20"
    }
  },
  "framework": "hugo",
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        }
      ]
    }
  ]
}
```

### **2. Environment Variables and Secrets**

- **Principle:** Manage sensitive data securely and separate configuration by environment.
- **Best Practices:**
  - Store sensitive values (API keys, tokens) as **Vercel Environment Variables** in the dashboard, not in `vercel.json`.
  - Use environment-specific variables for production, preview, and development environments.
  - Prefix environment variables appropriately (e.g., `NEXT_PUBLIC_` for client-side vars in Next.js).
  - Never commit `.env.local`, `.env.production`, or any files containing secrets.
  - Use `.vercelignore` to exclude sensitive files from deployment.
  - Reference environment variables in build commands or runtime code, not in configuration files.

### **3. Build Optimization**

- **Principle:** Optimize build times and output size for faster deployments and better performance.
- **Best Practices:**
  - **Cache Dependencies:** Vercel automatically caches dependencies between builds. Ensure `package-lock.json`, `yarn.lock`, or `pnpm-lock.yaml` is committed.
  - **Build Command:** Define clear build commands in `vercel.json` or `package.json`.
  - **Output Directory:** Specify the correct output directory (e.g., `public` for Hugo, `out` for Next.js static export).
  - **Framework Detection:** Let Vercel auto-detect your framework when possible for optimal defaults.
  - **Static Output:** For static sites, ensure all assets are generated during build time.
  - **Minimize Build Steps:** Remove unnecessary build steps or split them into separate workflows.

### **4. Hugo-Specific Best Practices**

- **Principle:** Configure Hugo for optimal Vercel deployment.
- **Best Practices:**
  - **Hugo Version:** Always specify the exact Hugo version in `vercel.json` or as a Vercel environment variable.
  - **Extended Version:** Use Hugo Extended if your theme requires SCSS/Sass processing.
  - **Base URL:** Configure `baseURL` in `hugo.toml`/`config.toml` to match your Vercel domain.
  - **Build Flags:** Use `--gc --minify` for production builds to optimize output.
  - **Theme Installation:** Use Git submodules for themes and ensure they're properly initialized.
  - **Content Organization:** Follow Hugo's content structure conventions for clean URLs.

```toml
# hugo.toml example
baseURL = 'https://your-site.vercel.app/'
languageCode = 'en-us'
title = 'Your Site'
theme = 'your-theme'

[build]
  writeStats = true
  
[minify]
  disableXML = true
  minifyOutput = true
```

### **5. Performance Optimization**

- **Principle:** Deliver fast page loads and optimal user experience.
- **Best Practices:**
  - **Image Optimization:** Use Vercel's Image Optimization API or optimize images during build.
  - **CDN:** Leverage Vercel's global Edge Network for fast content delivery.
  - **Caching Headers:** Set appropriate `Cache-Control` headers for static assets.
  - **Compression:** Enable gzip/brotli compression (enabled by default on Vercel).
  - **Asset Minification:** Minify CSS, JS, and HTML during build.
  - **Font Loading:** Use `font-display: swap` and preload critical fonts.
  - **Lazy Loading:** Implement lazy loading for images and non-critical resources.

### **6. Security Best Practices**

- **Principle:** Protect your site and users from common web vulnerabilities.
- **Best Practices:**
  - **Security Headers:** Configure security headers in `vercel.json`:
    - `X-Content-Type-Options: nosniff`
    - `X-Frame-Options: DENY` or `SAMEORIGIN`
    - `X-XSS-Protection: 1; mode=block`
    - `Referrer-Policy: strict-origin-when-cross-origin`
    - `Content-Security-Policy` (CSP) for advanced protection
  - **HTTPS Only:** Vercel enforces HTTPS by default, but ensure no mixed content.
  - **Environment Isolation:** Use separate Vercel projects or environments for staging and production.
  - **Access Control:** Use Vercel's Password Protection or Access Control for sensitive deployments.
  - **Secret Management:** Never expose API keys or secrets in client-side code.
  - **Dependency Scanning:** Regularly update dependencies and scan for vulnerabilities.

### **7. Preview Deployments**

- **Principle:** Every pull request should generate a preview deployment for testing.
- **Best Practices:**
  - Enable automatic preview deployments in Vercel project settings.
  - Use preview deployments for QA, stakeholder review, and testing.
  - Configure branch-specific settings if needed (e.g., staging branch).
  - Add preview URLs to pull request comments for easy access.
  - Test preview deployments thoroughly before merging to production.
  - Use Vercel's deployment protection for sensitive previews.

### **8. Custom Domains**

- **Principle:** Configure custom domains properly for production sites.
- **Best Practices:**
  - Add custom domains in Vercel project settings.
  - Configure DNS records correctly (A, AAAA, or CNAME records).
  - Enable automatic HTTPS certificate provisioning.
  - Set up domain redirects (www to non-www or vice versa).
  - Use Vercel's nameservers for easier management (optional).
  - Configure `baseURL` to match your custom domain.

### **9. Monitoring and Analytics**

- **Principle:** Track deployment health and site performance.
- **Best Practices:**
  - Use Vercel Analytics for real-time performance insights.
  - Monitor Core Web Vitals (LCP, FID, CLS).
  - Set up deployment notifications via Slack, email, or webhooks.
  - Review deployment logs for build errors or warnings.
  - Use Vercel's real-time logs for debugging serverless functions.
  - Integrate with external monitoring tools (Sentry, Datadog, etc.).

### **10. Deployment Workflows**

- **Principle:** Automate deployments with clear, reliable workflows.
- **Best Practices:**
  - **Automatic Deployments:** Connect GitHub repository to Vercel for automatic deployments on push.
  - **Branch Deployments:** Configure which branches trigger production vs. preview deployments.
  - **Manual Deployments:** Use Vercel CLI for manual deployments when needed: `vercel --prod`.
  - **Deployment Protection:** Enable deployment protection for production environments.
  - **Rollbacks:** Use Vercel's instant rollback feature to revert to previous deployments.
  - **Build Hooks:** Use build hooks to trigger deployments from external systems.

## Vercel CLI Best Practices

### Installation and Authentication

```bash
# Install Vercel CLI globally
npm install -g vercel

# Login to Vercel
vercel login

# Link project to existing Vercel project
vercel link
```

### Common Commands

```bash
# Deploy to production
vercel --prod

# Deploy to preview
vercel

# View deployment logs
vercel logs <deployment-url>

# List all deployments
vercel ls

# Remove a deployment
vercel rm <deployment-url>

# Pull environment variables
vercel env pull .env.local

# Add environment variable
vercel env add
```

## GitHub Actions Integration

### **Principle:** Integrate Vercel deployments with GitHub Actions for advanced workflows.

### **Best Practices:**

- Use the official `vercel/action` or Vercel CLI in GitHub Actions.
- Store Vercel tokens as GitHub Secrets (`VERCEL_TOKEN`).
- Store Vercel Organization ID and Project ID as GitHub Secrets.
- Create separate workflows for preview and production deployments.
- Add deployment status checks to pull requests.
- Use GitHub Environments for deployment protection.

### **Example Workflow:**

```yaml
name: Vercel Deploy

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          submodules: recursive

      - name: Install Vercel CLI
        run: npm install -g vercel

      - name: Pull Vercel Environment Information
        run: vercel pull --yes --environment=production --token=${{ secrets.VERCEL_TOKEN }}

      - name: Build Project Artifacts
        run: vercel build --prod --token=${{ secrets.VERCEL_TOKEN }}

      - name: Deploy to Vercel
        run: vercel deploy --prebuilt --prod --token=${{ secrets.VERCEL_TOKEN }}
        if: github.ref == 'refs/heads/main'

      - name: Deploy Preview
        run: vercel deploy --prebuilt --token=${{ secrets.VERCEL_TOKEN }}
        if: github.event_name == 'pull_request'
```

## Common Issues and Troubleshooting

### **Build Failures**

- Check build logs in Vercel dashboard for specific errors.
- Verify all dependencies are listed in `package.json`.
- Ensure build commands are correct and executable.
- Check for environment-specific issues (Node version, Hugo version).
- Verify submodules are properly initialized for Hugo themes.

### **Deployment Failures**

- Verify Vercel token has correct permissions.
- Check project and organization IDs are correct.
- Ensure no conflicting deployments are in progress.
- Review deployment protection settings.

### **Performance Issues**

- Analyze bundle size and optimize assets.
- Check Core Web Vitals in Vercel Analytics.
- Review caching headers and CDN configuration.
- Optimize images and fonts.

### **Domain Issues**

- Verify DNS records are correctly configured.
- Wait for DNS propagation (up to 48 hours).
- Check SSL certificate status in Vercel dashboard.
- Ensure no conflicting DNS records exist.

## Vercel Ignore File (`.vercelignore`)

### **Principle:** Exclude unnecessary files from deployment to reduce build time and deployment size.

### **Best Practices:**

```
# Development files
.env.local
.env.*.local
.vscode
.idea

# Testing
coverage
*.test.js
*.spec.js
__tests__

# Documentation
*.md
docs/
README*

# CI/CD
.github/
.gitlab/
.circleci/

# Source files (if building to dist)
src/
tests/

# Large files
*.log
*.mp4
*.mov
*.zip

# Node modules (if not needed)
node_modules/
```

## Checklist for New Vercel Project

- [ ] Create `vercel.json` with appropriate configuration
- [ ] Configure environment variables in Vercel dashboard
- [ ] Set up custom domain (if applicable)
- [ ] Enable automatic preview deployments
- [ ] Configure security headers
- [ ] Set up deployment notifications
- [ ] Test preview deployment workflow
- [ ] Configure production branch protection
- [ ] Enable Vercel Analytics
- [ ] Set up monitoring and alerting
- [ ] Document deployment process for team
- [ ] Create `.vercelignore` to exclude unnecessary files
- [ ] Test rollback procedure

## Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Vercel CLI Documentation](https://vercel.com/docs/cli)
- [Hugo on Vercel Guide](https://vercel.com/guides/deploying-hugo-with-vercel)
- [Vercel Environment Variables](https://vercel.com/docs/concepts/projects/environment-variables)
- [Vercel GitHub Integration](https://vercel.com/docs/concepts/git/vercel-for-github)
