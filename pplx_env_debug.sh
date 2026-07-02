#!/usr/bin/env bash
set -euo pipefail

set -a
[ -f /etc/environment ] && source /etc/environment || true
[ -f "$HOME/.profile" ] && source "$HOME/.profile" || true
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc" || true
set +a

API_KEY="${PPLX_API_KEY:-${PERPLEXITY_API_KEY:-}}"

echo "─────────────────────────────────────────"
echo "Perplexity Env Diagnose"
echo "─────────────────────────────────────────"

if [ -z "${API_KEY:-}" ]; then
  echo "STATUS: Kein Key gefunden"
  exit 1
fi

CLEAN_KEY="$(printf '%s' "$API_KEY" | tr -d '\r\n' | sed 's/^["'"'"']//; s/["'"'"']$//')"

echo "PPLX_API_KEY gesetzt:        ${PPLX_API_KEY:+ja}${PPLX_API_KEY:-nein}"
echo "PERPLEXITY_API_KEY gesetzt:  ${PERPLEXITY_API_KEY:+ja}${PERPLEXITY_API_KEY:-nein}"
echo "Geladene Key-Länge:          $(printf '%s' "$API_KEY" | wc -c)"
echo "Bereinigte Key-Länge:        $(printf '%s' "$CLEAN_KEY" | wc -c)"
echo "Key-Prefix:                  $(printf '%s' "$CLEAN_KEY" | cut -c1-10)..."
echo "Key-SHA256:                  $(printf '%s' "$CLEAN_KEY" | sha256sum | awk '{print $1}')"

echo ""
echo "Live-Test gegen Perplexity..."

HTTP_CODE="$(
curl -sS -o /tmp/pplx_debug_response.json -w "%{http_code}" \
  --request POST \
  --url "https://api.perplexity.ai/v1/sonar" \
  --header "Authorization: Bearer $CLEAN_KEY" \
  --header "Content-Type: application/json" \
  --data '{"model":"sonar","messages":[{"role":"user","content":"ping"}],"max_tokens":20,"stream":false}'
)"

echo "HTTP-Code: $HTTP_CODE"
echo "Response:"
cat /tmp/pplx_debug_response.json | jq . 2>/dev/null || cat /tmp/pplx_debug_response.json
echo ""
echo "─────────────────────────────────────────"

if [ "$HTTP_CODE" = "401" ]; then
  echo "BEFUND: Key ist ungültig, abgelaufen, falsch kopiert oder gehört nicht zur Perplexity-API."
elif [ "$HTTP_CODE" = "200" ]; then
  echo "BEFUND: Key funktioniert."
else
  echo "BEFUND: Kein reiner Key-Fehler. Prüfe Response oben."
fi
