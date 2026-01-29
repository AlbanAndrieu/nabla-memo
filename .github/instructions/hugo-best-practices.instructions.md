---
description: Hugo Static Site Generator Best Practices and Conventions
applyTo: 'hugo.toml,config.toml,config.yaml,archetypes/**,content/**,layouts/**,static/**,themes/**'
---
# Hugo Best Practices

## Your Mission

As GitHub Copilot, you are an expert in Hugo static site generation. Your mission is to assist developers in creating fast, maintainable, and SEO-optimized static websites using Hugo's powerful templating system and content management features.

## Core Concepts

### **1. Project Structure**

- **Principle:** Follow Hugo's conventional directory structure for clarity and maintainability.
- **Standard Structure:**

```
.
├── archetypes/          # Content templates
├── assets/              # Files to be processed (SCSS, JS, images)
├── content/             # Markdown content files
├── data/                # Data files (JSON, YAML, TOML)
├── layouts/             # Template files
│   ├── _default/        # Default templates
│   ├── partials/        # Reusable template components
│   └── shortcodes/      # Custom shortcodes
├── static/              # Static files (copied as-is)
├── themes/              # Hugo themes (often Git submodules)
├── hugo.toml            # Site configuration
└── public/              # Generated site (not committed)
```

- **Best Practices:**
  - Never commit the `public/` directory to version control.
  - Use `resources/` for processed assets cache (can be committed for CI optimization).
  - Keep themes as Git submodules for easier updates.
  - Organize content hierarchically to match desired URL structure.
  - Use `assets/` for files that need processing (SCSS, JS bundling).
  - Use `static/` for files that should be copied as-is (fonts, PDFs).

### **2. Configuration (`hugo.toml`)**

- **Principle:** Centralize site configuration for consistency and maintainability.
- **Best Practices:**
  - Use `hugo.toml` (TOML format) for better readability over YAML or JSON.
  - Set `baseURL` to your production URL (critical for SEO and asset paths).
  - Specify `languageCode` for proper language detection.
  - Configure `theme` if using a theme.
  - Set `title` for your site.
  - Use environment-specific config files: `config/_default/`, `config/production/`, `config/development/`.

**Example Configuration:**

```toml
baseURL = 'https://example.com/'
languageCode = 'en-us'
title = 'My Hugo Site'
theme = 'PaperMod'

# Performance
[caches]
  [caches.getjson]
    maxAge = "10m"

# Output formats
[outputs]
  home = ["HTML", "RSS", "JSON"]

# Minification
[minify]
  disableXML = true
  minifyOutput = true
  [minify.tdewolff.html]
    keepWhitespace = false

# Markup
[markup]
  [markup.goldmark.renderer]
    unsafe = true  # Allow HTML in markdown
  [markup.highlight]
    style = 'monokai'
    lineNos = true

# Params (custom site parameters)
[params]
  description = 'A fast and modern Hugo site'
  author = 'Your Name'
  
  [params.social]
    twitter = 'yourusername'
    github = 'yourusername'

# Menu
[[menu.main]]
  name = 'Home'
  url = '/'
  weight = 1

[[menu.main]]
  name = 'Blog'
  url = '/blog/'
  weight = 2

[[menu.main]]
  name = 'About'
  url = '/about/'
  weight = 3
```

### **3. Content Management**

- **Principle:** Organize content logically with proper front matter for flexibility and SEO.
- **Best Practices:**
  - **File Naming:** Use lowercase with hyphens: `my-blog-post.md`.
  - **Front Matter:** Use YAML or TOML front matter consistently.
  - **Required Fields:** Include `title`, `date`, and `draft` status.
  - **SEO Fields:** Add `description`, `keywords`, and `slug` for SEO optimization.
  - **Categories and Tags:** Use taxonomies consistently for better organization.
  - **Images:** Reference images using page bundles or static directory.

**Example Front Matter:**

```yaml
---
title: "Getting Started with Hugo"
date: 2024-01-29T10:00:00Z
draft: false
description: "A comprehensive guide to building static sites with Hugo"
tags: ["hugo", "static-site", "web-development"]
categories: ["tutorials"]
author: "John Doe"
image: "featured-image.jpg"
slug: "getting-started-hugo"
---
```

### **4. Page Bundles**

- **Principle:** Use page bundles to organize content with related resources.
- **Types:**
  - **Leaf Bundle:** `content/posts/my-post/index.md` (no children)
  - **Branch Bundle:** `content/posts/_index.md` (can have children)

- **Best Practices:**
  - Use leaf bundles for blog posts with images and resources.
  - Place images and resources in the same directory as `index.md`.
  - Reference resources relatively: `![Image](image.jpg)`.
  - Use headless bundles for reusable content blocks.

**Example Leaf Bundle:**

```
content/
└── posts/
    └── my-post/
        ├── index.md
        ├── featured-image.jpg
        └── diagram.png
```

### **5. Templates and Layouts**

- **Principle:** Create reusable, maintainable templates following Hugo's template hierarchy.
- **Best Practices:**
  - **Template Hierarchy:** Understand Hugo's template lookup order.
  - **Base Templates:** Use `baseof.html` for common structure.
  - **Partials:** Create small, reusable components in `layouts/partials/`.
  - **Shortcodes:** Build custom markdown extensions in `layouts/shortcodes/`.
  - **Conditionals:** Use Go template logic sparingly for readability.
  - **Context:** Always be aware of the current context (`.` in templates).

**Example Base Template (`layouts/_default/baseof.html`):**

```html
<!DOCTYPE html>
<html lang="{{ .Site.LanguageCode }}">
<head>
    {{ partial "head.html" . }}
</head>
<body>
    {{ partial "header.html" . }}
    <main>
        {{ block "main" . }}{{ end }}
    </main>
    {{ partial "footer.html" . }}
</body>
</html>
```

**Example Single Page Template (`layouts/_default/single.html`):**

```html
{{ define "main" }}
<article>
    <header>
        <h1>{{ .Title }}</h1>
        <time datetime="{{ .Date.Format "2006-01-02" }}">
            {{ .Date.Format "January 2, 2006" }}
        </time>
    </header>
    <div class="content">
        {{ .Content }}
    </div>
</article>
{{ end }}
```

### **6. Shortcodes**

- **Principle:** Extend Markdown with reusable components without HTML.
- **Best Practices:**
  - Create shortcodes for frequently used HTML patterns.
  - Keep shortcodes simple and focused on one task.
  - Support both positional and named parameters.
  - Provide sensible defaults for parameters.

**Example Shortcode (`layouts/shortcodes/figure.html`):**

```html
<figure{{ with .Get "class" }} class="{{ . }}"{{ end }}>
    <img src="{{ .Get "src" }}" alt="{{ .Get "alt" }}">
    {{ with .Get "caption" }}
    <figcaption>{{ . | markdownify }}</figcaption>
    {{ end }}
</figure>
```

**Usage in Markdown:**

```markdown
{{< figure src="image.jpg" alt="Description" caption="Image caption" >}}
```

### **7. Performance Optimization**

- **Principle:** Generate fast, optimized static sites.
- **Best Practices:**
  - **Minification:** Enable minification in config for HTML, CSS, JS.
  - **Image Processing:** Use Hugo's image processing for responsive images.
  - **Asset Pipelines:** Use Hugo Pipes for SCSS compilation and JS bundling.
  - **Lazy Loading:** Implement lazy loading for images.
  - **Cache Busting:** Use Hugo's fingerprinting for assets.
  - **Build Flags:** Use `--gc --minify` for production builds.

**Example Image Processing:**

```html
{{ $image := .Resources.GetMatch "featured-image.jpg" }}
{{ $small := $image.Resize "400x" }}
{{ $medium := $image.Resize "800x" }}
{{ $large := $image.Resize "1200x" }}

<img
    src="{{ $medium.RelPermalink }}"
    srcset="{{ $small.RelPermalink }} 400w,
            {{ $medium.RelPermalink }} 800w,
            {{ $large.RelPermalink }} 1200w"
    sizes="(max-width: 400px) 400px,
           (max-width: 800px) 800px,
           1200px"
    alt="{{ .Title }}"
    loading="lazy"
>
```

### **8. SEO Best Practices**

- **Principle:** Optimize for search engines and social sharing.
- **Best Practices:**
  - **Meta Tags:** Include proper meta tags for description, keywords, and Open Graph.
  - **Sitemap:** Enable automatic sitemap generation.
  - **RSS Feed:** Provide RSS feeds for content.
  - **Canonical URLs:** Set proper canonical URLs.
  - **Robots.txt:** Configure robots.txt appropriately.
  - **Schema.org:** Add structured data using JSON-LD.

**Example SEO Partial (`layouts/partials/seo.html`):**

```html
<meta name="description" content="{{ .Description | default .Site.Params.description }}">
<meta name="keywords" content="{{ delimit .Keywords ", " }}">
<link rel="canonical" href="{{ .Permalink }}">

<!-- Open Graph -->
<meta property="og:title" content="{{ .Title }}">
<meta property="og:description" content="{{ .Description | default .Site.Params.description }}">
<meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}">
<meta property="og:url" content="{{ .Permalink }}">
{{ with .Params.image }}
<meta property="og:image" content="{{ . | absURL }}">
{{ end }}

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{{ .Title }}">
<meta name="twitter:description" content="{{ .Description | default .Site.Params.description }}">
{{ with .Params.image }}
<meta name="twitter:image" content="{{ . | absURL }}">
{{ end }}
```

### **9. Theme Development**

- **Principle:** Create flexible, customizable themes.
- **Best Practices:**
  - Use Git submodules for theme management.
  - Override theme files by copying to project root with same path.
  - Create theme variants using configuration parameters.
  - Document theme configuration options thoroughly.
  - Follow semantic versioning for theme releases.
  - Test themes with various content types and structures.

### **10. Content Organization**

- **Principle:** Structure content for logical navigation and URL patterns.
- **Best Practices:**
  - **Sections:** Use top-level directories for main content sections.
  - **Taxonomies:** Use tags and categories consistently.
  - **URL Structure:** Control URLs with `slug` or `url` in front matter.
  - **List Pages:** Create `_index.md` for section list pages.
  - **Pagination:** Configure pagination for long lists.

**Example Content Structure:**

```
content/
├── _index.md              # Homepage content
├── about.md               # Single page
├── blog/
│   ├── _index.md          # Blog list page
│   ├── post-1.md
│   └── post-2.md
└── docs/
    ├── _index.md
    ├── getting-started/
    │   ├── _index.md
    │   ├── installation.md
    │   └── configuration.md
    └── advanced/
        ├── _index.md
        └── optimization.md
```

## Hugo Development Workflow

### **1. Local Development**

```bash
# Start development server with drafts
hugo server -D

# Start with live reload
hugo server -D --disableFastRender

# Start with specific config
hugo server --environment development

# Build site
hugo

# Build with production settings
hugo --gc --minify
```

### **2. Content Creation**

```bash
# Create new post
hugo new posts/my-new-post.md

# Create new post using archetype
hugo new posts/my-post/index.md

# Create new section
hugo new docs/_index.md
```

### **3. Testing**

- Test locally before deploying.
- Check all links work correctly.
- Verify responsive design on different devices.
- Test with different browsers.
- Validate HTML and CSS.
- Check page load performance.

## Common Pitfalls and Solutions

### **Problem: Broken Images**

- **Solution:** Use absolute paths with `absURL` or relative paths correctly.
- **Solution:** Place images in `static/` or use page bundles.

### **Problem: Template Not Found**

- **Solution:** Check template hierarchy and naming conventions.
- **Solution:** Ensure templates are in correct directories.

### **Problem: Changes Not Reflecting**

- **Solution:** Clear Hugo cache: `hugo --gc`.
- **Solution:** Restart development server.
- **Solution:** Check if file is in `static/` (requires restart).

### **Problem: Build Errors**

- **Solution:** Check front matter YAML/TOML syntax.
- **Solution:** Verify template Go syntax.
- **Solution:** Ensure all required theme files exist.

## Hugo CLI Commands Reference

```bash
# Version
hugo version

# Create new site
hugo new site mysite

# Add theme as submodule
git submodule add https://github.com/theme/repo themes/themename

# Initialize submodules (after clone)
git submodule update --init --recursive

# Update theme
git submodule update --remote themes/themename

# List content
hugo list all
hugo list drafts
hugo list future

# Check configuration
hugo config

# Convert content
hugo convert toYAML
hugo convert toTOML
hugo convert toJSON

# Generate man pages
hugo gen man
```

## Hugo Configuration Best Practices

### **Environment-Specific Configs**

```
config/
├── _default/
│   ├── config.toml
│   ├── menus.toml
│   └── params.toml
├── production/
│   └── config.toml
└── development/
    └── config.toml
```

### **Build Configuration**

```toml
[build]
  writeStats = true
  useResourceCacheWhen = "fallback"

[outputs]
  home = ["HTML", "RSS", "JSON"]
  section = ["HTML", "RSS"]

[outputFormats.RSS]
  mediatype = "application/rss"
  baseName = "feed"
```

## Hugo Version Management

- **Principle:** Ensure consistent Hugo versions across environments.
- **Best Practices:**
  - Specify exact Hugo version in CI/CD (e.g., Vercel, GitHub Actions).
  - Document required Hugo version in README.
  - Use Hugo Extended if theme requires SCSS processing.
  - Keep Hugo version updated but test before upgrading.
  - Use version managers like `asdf` or `mise` for local development.

## Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Hugo Themes](https://themes.gohugo.io/)
- [Hugo Discourse Forum](https://discourse.gohugo.io/)
- [Hugo GitHub Repository](https://github.com/gohugoio/hugo)
- [Go Template Documentation](https://pkg.go.dev/text/template)

## Checklist for New Hugo Project

- [ ] Install Hugo Extended (if needed)
- [ ] Create new site: `hugo new site mysite`
- [ ] Add theme as Git submodule
- [ ] Configure `hugo.toml` with baseURL, title, theme
- [ ] Create initial content structure
- [ ] Set up archetypes for content types
- [ ] Configure menus and navigation
- [ ] Add SEO meta tags in head partial
- [ ] Set up RSS feed
- [ ] Configure sitemap
- [ ] Test local build and development server
- [ ] Set up deployment pipeline (Vercel, Netlify, etc.)
- [ ] Configure analytics and monitoring
- [ ] Document site structure and conventions
- [ ] Add `.gitignore` for Hugo (public/, resources/)
