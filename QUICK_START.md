# Quick Start Guide

Welcome! This guide will help you get started with the Hugo site in just a few minutes.

## 🚀 For First-Time Users

### Step 1: Clone the Repository

```bash
git clone --recurse-submodules https://github.com/AlbanAndrieu/nabla-memo.git
cd nabla-memo
```

> **Important**: Use `--recurse-submodules` to include the Hugo theme!

### Step 2: Install Hugo

**macOS:**
```bash
brew install hugo
```

**Windows:**
```bash
choco install hugo-extended
```

**Linux:**
Download from [Hugo Releases](https://github.com/gohugoio/hugo/releases/tag/v0.146.0)

### Step 3: Run Locally

```bash
hugo server -D
```

Open http://localhost:1313 in your browser!

## 🌐 For Deployment

### Option 1: Automatic Deployment (Recommended)

1. **Set up Vercel account** at https://vercel.com

2. **Add GitHub secrets** to your repository:
   - Go to Settings → Secrets and variables → Actions
   - Add three secrets:
     - `VERCEL_TOKEN`
     - `VERCEL_ORG_ID`
     - `VERCEL_PROJECT_ID`
   
   See [VERCEL_GITHUB_ACTIONS_SETUP.md](VERCEL_GITHUB_ACTIONS_SETUP.md) for detailed instructions.

3. **Push to main branch**:
   ```bash
   git push origin main
   ```
   
   GitHub Actions will automatically deploy to Vercel!

### Option 2: Manual Deployment

```bash
npm install -g vercel
vercel --prod
```

## ✏️ Adding Content

### Create a New Page

```bash
hugo new content/my-page.md
```

Edit the file and set `draft: false` when ready to publish.

### Create a Blog Post

```bash
hugo new posts/my-first-post.md
```

## 📝 Editing Existing Content

1. Homepage: Edit `content/_index.md`
2. About page: Edit `content/about.md`
3. Configuration: Edit `hugo.toml`

## 🎨 Customization

### Change Site Title

Edit `hugo.toml`:
```toml
title = 'Your Site Name'
```

### Change Base URL

Edit `hugo.toml`:
```toml
baseURL = 'https://your-domain.com/'
```

### Customize Theme

See [PaperMod documentation](https://github.com/adityatelange/hugo-PaperMod/wiki)

## 🔧 Common Commands

```bash
# Run development server
hugo server -D

# Build for production
hugo --gc --minify

# Create new content
hugo new content/page-name.md

# Update theme
git submodule update --remote themes/PaperMod
```

## ❓ Troubleshooting

### Theme not found?

```bash
git submodule update --init --recursive
```

### Wrong Hugo version?

Check version: `hugo version`

Should be v0.146.0 or higher (Extended)

### Build errors?

1. Clean build: `rm -rf public resources`
2. Rebuild: `hugo --gc --minify`

## 📚 More Information

- [Full Hugo Deployment Guide](HUGO_DEPLOYMENT.md)
- [Vercel GitHub Actions Setup](VERCEL_GITHUB_ACTIONS_SETUP.md)
- [Complete Setup Summary](SETUP_SUMMARY.md)

## 🆘 Need Help?

1. Check the documentation files
2. Review [Hugo Documentation](https://gohugo.io/documentation/)
3. Check [PaperMod Wiki](https://github.com/adityatelange/hugo-PaperMod/wiki)
4. Review GitHub Actions logs for deployment issues

---

**Happy building! 🎉**
