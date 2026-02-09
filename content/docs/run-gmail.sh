#!/bin/bash
set -xv

# https://mail.google.com/mail/u/0/#advanced-search/attach_or_drive=true&query=larger%3A1M&isrefinement=true&attachtypes=zip
# https://mail.google.com/mail/u/0/#advanced-search/attach_or_drive=true&isrefinement=true&attachtypes=presentation

# https://github.com/dani-garcia/vaultwarden/wiki/SMTP-Configuration#googlegmail
# Create app password at : https://myaccount.google.com/u/1/apppasswords

# https://support.google.com/accounts/answer/185833?hl=en&ref_topic=7189145

FullSSL:

  # Domains: gmail.com, googlemail.com
  SMTP_HOST=smtp.gmail.com
  SMTP_PORT=465
  SMTP_SECURITY=force_tls
  SMTP_FROM=alban.andrieu@nabla.mobi
  SMTP_USERNAME=alban.andrieu@nabla.mobi
  SMTP_PASSWORD=Secure-App-Pass

StartTLS:

  # Domains: gmail.com, googlemail.com
  SMTP_HOST=smtp.gmail.com
  SMTP_PORT=587
  SMTP_SECURITY=starttls
  SMTP_FROM=alban.andrieu@nabla.mobi
  SMTP_USERNAME=alban.andrieu@nabla.mobi
  SMTP_PASSWORD=Secure-App-Pass

exit 0
