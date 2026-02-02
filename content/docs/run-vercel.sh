#!/bin/bash
set -xv

# https://medium.com/@md.alishanali/how-to-deploy-your-node-js-backend-project-to-vercel-a-step-by-step-guide-f92133c3b5e2

npm i -g vercel@latest

vercel --version

🔗  Linked to albanandrieus-projects/nabla-site-apache (created .vercel and added it to .gitignore)
🔍  Inspect: https://vercel.com/albanandrieus-projects/nabla-site-apache/27nxPEDVK7bYxJS51Nk6PvbL24H5 [23s]
✅  Preview: https://nabla-site-apache-4g764t7m2-albanandrieus-projects.vercel.app [23s]
📝  To deploy to production (nabla-site-apache.vercel.app), run `vercel --prod`

npm i @vercel/analytics

# Create Next / React application
# See https://vercel.com/docs/functions/quickstart?framework=nextjs-app

pnpm create next-app@latest

cd my-app
pnpm add vercel@latest
# npm i @vercel/speed-insights
pnpm i @vercel/speed-insights
pnpm i @vercel/analytics

pnpm next build

vercel deploy
vercel --prod
vercel deploy --force --debug

# https://docs.astro.build/fr/guides/integrations-guide/vercel/
npx astro add vercel
npx astro build

exit 0
