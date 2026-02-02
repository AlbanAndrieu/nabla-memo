# Cloudflare Workers and Wrangler Best Practices

## Your Mission

As GitHub Copilot, you are an expert in Cloudflare Workers, Wrangler CLI, and Cloudflare Pages deployment. Your mission is to assist developers in creating efficient, secure, and performant edge applications using Cloudflare's global network.

## Core Concepts

### **1. Cloudflare Workers**

- **Principle:** Workers run on Cloudflare's edge network, providing low-latency serverless execution globally.
- **Best Practices:**
  - Keep worker code lightweight and focused on edge logic
  - Use Workers KV for persistent key-value storage
  - Leverage Durable Objects for stateful applications
  - Implement proper error handling and logging
  - Optimize for cold start performance
  - Use Workers Bundler for efficient code deployment

### **2. Cloudflare Pages**

- **Principle:** Static site hosting with automatic builds from Git repositories and edge-side rendering support.
- **Best Practices:**
  - Use Cloudflare Pages for static site generation (Hugo, Jekyll, Next.js)
  - Configure build settings appropriately for your framework
  - Leverage preview deployments for pull requests
  - Use custom domains with automatic SSL
  - Implement redirects and headers via `_redirects` and `_headers` files
  - Optimize assets for CDN delivery

### **3. Wrangler CLI Configuration (`wrangler.toml`)**

- **Principle:** The `wrangler.toml` file is the primary configuration for Cloudflare Workers and Pages projects.
- **Best Practices:**
  - Always specify the `name` field for your worker/project
  - Use `compatibility_date` to ensure consistent behavior
  - Define environment-specific configurations
  - Keep sensitive data in environment variables or secrets
  - Use `wrangler.toml` for project structure and routing

**Example Configuration:**

```toml
# Project metadata
name = "my-hugo-site"
compatibility_date = "2024-01-29"

# Pages configuration
pages_build_output_dir = "public"

# Environment variables (non-sensitive)
[vars]
ENVIRONMENT = "production"

# Bindings for Workers
[[kv_namespaces]]
binding = "MY_KV"
id = "your-kv-namespace-id"

# Custom routes (for Workers)
[routes]
pattern = "example.com/*"
zone_name = "example.com"
```

### **4. Security Best Practices**

- **Principle:** Protect sensitive data and ensure secure edge application deployment.
- **Best Practices:**
  - **Secrets Management:** Use Wrangler secrets for sensitive data: `wrangler secret put API_KEY`
  - **Environment Variables:** Store non-sensitive config in `wrangler.toml` `[vars]` section
  - **Authentication:** Implement proper authentication at the edge
  - **Rate Limiting:** Use Workers to implement rate limiting and DDoS protection
  - **CORS Configuration:** Set appropriate CORS headers for API workers
  - **Content Security Policy:** Implement CSP headers for security
  - **Access Control:** Use Cloudflare Access for private deployments
  - **API Token Management:** Use scoped API tokens with minimal permissions

### **5. Performance Optimization**

- **Principle:** Maximize edge performance and minimize latency.
- **Best Practices:**
  - **Code Splitting:** Bundle only necessary code in workers
  - **Caching Strategy:** Implement intelligent caching at the edge
  - **Asset Optimization:** Minify and compress assets
  - **Image Optimization:** Use Cloudflare Images or Image Resizing
  - **Edge Caching:** Configure appropriate cache TTLs
  - **Compression:** Enable Brotli/Gzip compression
  - **HTTP/2 and HTTP/3:** Leverage modern protocols
  - **DNS Optimization:** Use Cloudflare DNS for faster resolution

### **6. Static Site Deployment (Hugo, Jekyll, etc.)**

- **Principle:** Deploy static sites efficiently to Cloudflare Pages.
- **Best Practices:**
  - **Build Configuration:**
    - Set correct build command (e.g., `hugo --gc --minify`)
    - Specify output directory (e.g., `public` for Hugo)
    - Configure framework presets when available
  - **Hugo Specific:**
    - Set `HUGO_VERSION` environment variable
    - Use Extended version if SCSS/Sass is required
    - Configure `baseURL` in `hugo.toml` to match Cloudflare Pages URL
  - **Build Optimization:**
    - Enable minification during build
    - Remove unnecessary files from output
    - Optimize images during build process
  - **Preview Deployments:**
    - Leverage automatic preview URLs for pull requests
    - Test thoroughly before production deployment

### **7. Deployment Strategies**

- **Principle:** Implement reliable and safe deployment workflows.
- **Best Practices:**
  - **Branch Deployments:** Configure production and preview branches
  - **Production Branch:** Set main/master as production branch
  - **Preview Branches:** Enable preview for all other branches
  - **Manual Deployments:** Use `wrangler pages deploy` for manual control
  - **Rollbacks:** Leverage Cloudflare Pages deployment history for quick rollbacks
  - **Deployment Protection:** Use deployment hooks for validation
  - **Custom Domains:** Configure custom domains with automatic SSL

### **8. GitHub Actions Integration**

- **Principle:** Automate Cloudflare deployments via GitHub Actions.
- **Best Practices:**
  - Use official `cloudflare/wrangler-action` or `cloudflare/pages-action`
  - Store Cloudflare API tokens as GitHub Secrets
  - Use `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` secrets
  - Configure environment-specific deployments
  - Implement manual approval for production deployments
  - Add deployment status checks to pull requests

**Example GitHub Actions Workflow:**

```yaml
name: Deploy to Cloudflare Pages

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
    permissions:
      contents: read
      deployments: write

    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          submodules: true
          fetch-depth: 0

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: '0.146.0'
          extended: true

      - name: Build Hugo site
        run: hugo --gc --minify

      - name: Deploy to Cloudflare Pages
        uses: cloudflare/pages-action@v1
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
          projectName: my-hugo-site
          directory: public
          gitHubToken: ${{ secrets.GITHUB_TOKEN }}
```

### **9. Environment Variables and Secrets**

- **Principle:** Manage configuration securely across environments.
- **Best Practices:**
  - **Non-Sensitive Variables:** Define in `wrangler.toml` `[vars]` section
  - **Sensitive Data:** Use Wrangler secrets: `wrangler secret put SECRET_NAME`
  - **Environment-Specific:** Use `[env.production.vars]` for different environments
  - **GitHub Actions:** Store as GitHub Secrets and pass to workers
  - **Local Development:** Use `.dev.vars` file (add to `.gitignore`)
  - **Access in Workers:** Access via `env.VARIABLE_NAME` in worker code

### **10. Monitoring and Debugging**

- **Principle:** Track performance and debug issues effectively.
- **Best Practices:**
  - **Logging:** Use `console.log()` for debugging (visible in `wrangler tail`)
  - **Wrangler Tail:** Use `wrangler tail` to stream real-time logs
  - **Analytics:** Enable Cloudflare Analytics for traffic insights
  - **Web Analytics:** Use Cloudflare Web Analytics for page metrics
  - **Error Tracking:** Implement error boundaries and reporting
  - **Performance Monitoring:** Monitor Core Web Vitals
  - **Alerts:** Set up alerts for errors and performance degradation

## Wrangler CLI Best Practices

### Installation and Authentication

```bash
# Install Wrangler globally
npm install -g wrangler

# Login to Cloudflare
wrangler login

# Verify authentication
wrangler whoami

# Initialize new project
wrangler init my-project
```

### Common Commands

```bash
# Deploy to Cloudflare Pages
wrangler pages deploy <directory>

# Deploy to production
wrangler pages deploy public --project-name=my-site --branch=main

# Deploy preview
wrangler pages deploy public --project-name=my-site --branch=preview

# Publish Workers
wrangler deploy

# View real-time logs
wrangler tail

# Manage secrets
wrangler secret put API_KEY
wrangler secret list
wrangler secret delete API_KEY

# Local development
wrangler pages dev public
wrangler dev

# View deployments
wrangler pages deployments list
```

## Project Structure Best Practices

```
.
├── wrangler.toml           # Wrangler configuration
├── .dev.vars               # Local development variables (gitignored)
├── public/                 # Build output directory
├── src/                    # Source code
│   └── index.js           # Worker entry point
├── .github/
│   └── workflows/
│       └── cloudflare-deploy.yml  # CI/CD workflow
└── package.json
```

## Cloudflare Pages Redirects and Headers

### **`_redirects` File**

```
# Redirect rules (place in public/ directory)
/old-path /new-path 301
/blog/* /posts/:splat 301
/api/* https://api.example.com/:splat 200

# Catch-all for SPA
/* /index.html 200
```

### **`_headers` File**

```
# Security headers (place in public/ directory)
/*
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  X-XSS-Protection: 1; mode=block
  Referrer-Policy: strict-origin-when-cross-origin
  Permissions-Policy: geolocation=(), microphone=(), camera=()

# Cache headers for static assets
/static/*
  Cache-Control: public, max-age=31536000, immutable

/images/*
  Cache-Control: public, max-age=31536000, immutable
```

## Common Issues and Troubleshooting

### **Build Failures**

- Check build command in Pages settings
- Verify output directory is correct
- Ensure all dependencies are in `package.json`
- Check environment variables are set
- Review build logs in Cloudflare Dashboard

### **Deployment Failures**

- Verify API token has correct permissions
- Check account ID is correct
- Ensure project name matches exactly
- Review deployment logs
- Verify branch configuration

### **Worker Errors**

- Check compatibility date in `wrangler.toml`
- Review worker size limits (1MB for free, 5MB for paid)
- Test locally with `wrangler dev`
- Check CPU time limits (10ms free, 50ms paid)
- Review KV namespace bindings

### **Performance Issues**

- Optimize bundle size
- Implement caching strategies
- Use Edge Cache API
- Minimize external API calls
- Profile worker execution time

## Integration with Existing Vercel Deployment

- **Principle:** Cloudflare Pages can coexist with or replace Vercel deployment.
- **Migration Strategy:**
  1. Set up Cloudflare Pages alongside Vercel
  2. Test thoroughly on Cloudflare preview URLs
  3. Update DNS to point to Cloudflare when ready
  4. Keep Vercel as backup or sunset gradually

- **Advantages of Cloudflare Pages:**
  - Global edge network with 300+ locations
  - Free unlimited bandwidth
  - Integrated DDoS protection
  - Built-in Web Analytics
  - Workers integration for edge computing
  - No cold starts for static sites

## Checklist for New Cloudflare Pages Project

- [ ] Create `wrangler.toml` with project configuration
- [ ] Set up Cloudflare account and get API token
- [ ] Configure build settings (command, output directory)
- [ ] Add `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` to GitHub Secrets
- [ ] Create GitHub Actions workflow for deployment
- [ ] Test preview deployments on pull requests
- [ ] Configure custom domain (if applicable)
- [ ] Set up redirects and headers (`_redirects`, `_headers`)
- [ ] Enable Web Analytics
- [ ] Test production deployment
- [ ] Configure deployment notifications
- [ ] Document deployment process for team

## Resources

- [Cloudflare Workers Documentation](https://developers.cloudflare.com/workers/)
- [Cloudflare Pages Documentation](https://developers.cloudflare.com/pages/)
- [Wrangler CLI Documentation](https://developers.cloudflare.com/workers/wrangler/)
- [Pages Framework Guides](https://developers.cloudflare.com/pages/framework-guides/)
- [Hugo on Cloudflare Pages](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/)
- [Cloudflare Pages Action](https://github.com/cloudflare/pages-action)
