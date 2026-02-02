#!/bin/bash
set -xv
curl https://bisq.network/pubkey/29CDFD3B.asc|  gpg --import
gpg --edit-key CD5DC1C529CDFD3B
trust
3
exit 0
