#!/bin/bash
set -xv

#OpenId
#http://www.google.com/a/cpanel/nabla.mobi/SetupIdp
#TODO SONAR connect to OpenID

# Generate the RSA keys and certificate
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -sha1 -subj \
  '/C=FR/ST=IDF/L=Paris/CN=www.nabla.mobi' -keyout \
  nablarsakey.pem -out /tmp/nablarsacert.pem

Incoming Mail (IMAP) Server - Requires SSL
imap.gmail.com
Port: 993
Requires SSL:Yes

Outgoing Mail (SMTP) Server - Requires TLS
smtp.gmail.com
Port: 465 (or 587)
Requires SSL: Yes
Requires authentication: Yes
Use same settings as incoming mail server

# Create app password at : https://myaccount.google.com/u/1/apppasswords

# My google analytics account ID : 6193226312
OLD : UA-56011797-1
# https://tagmanager.google.com/?authuser=0#/container/accounts/6092067479/containers/112584820/workspaces/0/config
GTM Nabla - GA4 : G-RHL13BHK6K, GT-5NTCTDF
G-RHL13BHK6K is the measurement ID
# https://tagmanager.google.com/?authuser=0#/home
# For container www.bababou.albandrieu.com
OLD : GTM-5RGCWJ7L
# For container www.albandrieu.com
GTM-W7XNV7K6

# Add Google Search Console
# Add in DNS for bababou.albandrieu.com TXT
# Transferered to https://account.squarespace.com/

# Safe Browsing site status
# Check :
# NOK : https://transparencyreport.google.com/safe-browsing/search?url=https:%2F%2Fbababou.albandrieu.com%2F&hl=en
# NOK : https://transparencyreport.google.com/safe-browsing/search?url=https:%2F%2Falbandrieu.com%2F&hl=en
# https://transparencyreport.google.com/safe-browsing/search?url=https:%2F%2Fhome.albandrieu.com%2F&hl=en

#https://www.thefanclub.co.za/overgrive

#https://console.developers.google.com/apis/dashboard?project=nabla-01

#ID de l organisation gcloud
1069974290280

# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk

# Google Dorks search
# filetype:pdf site:jusmundi.com intext:awards
# filetype:py

# See https://search.google.com/search-console?resource_id=sc-domain%3Aalbandrieu.com

# unfurling
# See https://medium.com/slack-developer-blog/everything-you-ever-wanted-to-know-about-unfurling-but-were-afraid-to-ask-or-how-to-make-your-e64b4bb9254
# perf SEO rich text

# https://search.google.com/test/rich-results?url=https%3A%2F%2Falbandrieu.com%2F&url=https%3A%2F%2Falbandrieu.com%2F

# https://www.linkedin.com/post-inspector/inspect/https:%2F%2Falbandrieu.com
# https://www.linkedin.com/post-inspector/inspect/https:%2F%2Fbababou.albandrieu.com

# Test Google analytics
# OK for https://alban.albandrieu.com/nabla/index/index.html
# OK for https://alban.albandrieu.com/nabla/index.html and https://alban.albandrieu.com
# Google Tag for Consent, linked with Cloudflare Zaraz Plan Tag Management
echo "https://albandrieu.com/analytics"

# Switch gmail alban.andrieu@nabla.mobi from pop to imap

# pop.free.fr
# port 110

# Auto-Expunge on - Immediately update the server. (default)


exit 0
