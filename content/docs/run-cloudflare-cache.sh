for url in $(head -n800 urls.txt); do
  content="$(curl -sI $url | grep "cf-cache-status")"
  if test -z "$content"; then
    continue
  else
    echo "$url || $content" >>cloudflare.txt
  fi
done
