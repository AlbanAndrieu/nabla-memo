#!/bin/bash
set -xv
FullSSL:
  SMTP_HOST=smtp.gmail.com
  SMTP_PORT=465
  SMTP_SECURITY=force_tls
  SMTP_FROM=alban.andrieu@nabla.mobi
  SMTP_USERNAME=alban.andrieu@nabla.mobi
  SMTP_PASSWORD=Secure-App-Pass
StartTLS:
  SMTP_HOST=smtp.gmail.com
  SMTP_PORT=587
  SMTP_SECURITY=starttls
  SMTP_FROM=alban.andrieu@nabla.mobi
  SMTP_USERNAME=alban.andrieu@nabla.mobi
  SMTP_PASSWORD=Secure-App-Pass
exit 0
