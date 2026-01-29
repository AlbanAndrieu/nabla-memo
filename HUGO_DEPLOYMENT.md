# Hugo Deployment Guide

This repository contains a Hugo static site that can be deployed to Vercel.

## Local Development

### Prerequisites

- Hugo Extended v0.146.0 or higher
- Git

### Installation

1. Install Hugo:
   - macOS: `brew install hugo`
   - Windows: `choco install hugo-extended`
   - Linux: Download from [Hugo Releases](https://github.com/gohugoio/hugo/releases)

2. Clone the repository:
   ```bash
   git clone --recurse-submodules https://github.com/AlbanAndrieu/nabla-memo.git
   cd nabla-memo
   ```

3. If you already cloned without submodules:
   ```bash
   git submodule update --init --recursive
   ```

### Running Locally

Start the Hugo development server:

```bash
hugo server -D
```

The site will be available at `http://localhost:1313`

### Building

To build the site for production:

```bash
hugo --gc --minify
```

The built site will be in the `public/` directory.

## Deployment

### Automatic Deployment with GitHub Actions

The repository is configured with GitHub Actions to automatically deploy to Vercel:

- **Production**: Pushes to `master` or `main` branch trigger production deployment
- **Preview**: Pull requests trigger preview deployments

### Required Secrets

Configure the following secrets in your GitHub repository settings:

1. `VERCEL_TOKEN`: Your Vercel authentication token
   - Get it from: https://vercel.com/account/tokens

2. `VERCEL_ORG_ID`: Your Vercel organization ID
   - Find it in your Vercel project settings

3. `VERCEL_PROJECT_ID`: Your Vercel project ID
   - Find it in your Vercel project settings

### Manual Deployment to Vercel

1. Install Vercel CLI:
   ```bash
   npm install -g vercel
   ```

2. Deploy:
   ```bash
   vercel
   ```

3. For production:
   ```bash
   vercel --prod
   ```

## Project Structure

```
.
├── archetypes/          # Content templates
├── content/             # Markdown content files
│   ├── _index.md       # Homepage content
│   └── about.md        # About page
├── themes/              # Hugo themes
│   └── PaperMod/       # PaperMod theme (submodule)
├── public/              # Built site (generated)
├── hugo.toml            # Hugo configuration
├── vercel.json          # Vercel configuration
└── .github/
    └── workflows/
        └── vercel-deploy.yml  # GitHub Actions workflow
```

## Configuration

### Hugo Configuration (`hugo.toml`)

Key settings:
- `baseURL`: Your site's URL
- `theme`: The Hugo theme to use
- `languageCode`: Site language
- `title`: Site title

### Vercel Configuration (`vercel.json`)

Key settings:
- `framework`: Set to "hugo"
- `build.env.HUGO_VERSION`: Hugo version to use

## Content Management

### Creating New Pages

```bash
hugo new content/your-page.md
```

### Creating Blog Posts

```bash
hugo new posts/my-first-post.md
```

Then edit the file and set `draft: false` when ready to publish.

## Theme

This project uses the [PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme, which provides:
- Clean, minimal design
- Dark mode support
- Mobile responsive
- Fast page load times

## Troubleshooting

### Submodule Issues

If the theme is missing:
```bash
git submodule update --init --recursive
```

### Build Errors

Ensure you're using Hugo Extended v0.146.0+:
```bash
hugo version
```

### Vercel Deployment Issues

1. Check that secrets are properly configured
2. Verify Hugo version in `vercel.json` matches requirements
3. Review GitHub Actions logs for detailed error messages

## Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [PaperMod Theme Documentation](https://github.com/adityatelange/hugo-PaperMod/wiki)
- [Vercel Documentation](https://vercel.com/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
