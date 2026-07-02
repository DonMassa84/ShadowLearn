#!/usr/bin/env bash
# textbot_key_check.sh
# Prüft Perplexity-API-Keys ohne den Key auszugeben.
# Keine Secrets in Logs oder Ausgabe.

set -euo pipefail

PLACEHOLDERS=("" "pxp_xxx" "dein_key" "dein-key" "changeme" "test" "dummy" "your_key" "xxx" "none" "null")

is_placeholder() {
    local val="${1,,}"  # lowercase
    local len=${#val}
    if [[ $len -lt 10 ]]; then return 0; fi
    for ph in "${PLACEHOLDERS[@]}"; do
        if [[ "$val" == "${ph,,}" ]]; then return 0; fi
    done
    return 1
}

echo "=== Perplexity API-Key Check ==="
echo ""

PXLX="${PERPLEXITY_API_KEY:-}"
PPLX="${PPLX_API_KEY:-}"

if is_placeholder "$PXLX"; then
    echo "PERPLEXITY_API_KEY: nicht gesetzt oder Platzhalter"
    PXLX_OK=0
else
    echo "PERPLEXITY_API_KEY: gesetzt (${#PXLX} Zeichen)"
    PXLX_OK=1
fi

if is_placeholder "$PPLX"; then
    echo "PPLX_API_KEY:       nicht gesetzt oder Platzhalter"
    PPLX_OK=0
else
    echo "PPLX_API_KEY:       gesetzt (${#PPLX} Zeichen)"
    PPLX_OK=1
fi

# /etc/environment Platzhalter-Warnung
if grep -q "PPLX_API_KEY" /etc/environment 2>/dev/null; then
    ETC_VAL=$(grep "PPLX_API_KEY" /etc/environment | cut -d= -f2- | tr -d '"' | tr -d "'")
    if is_placeholder "$ETC_VAL"; then
        echo ""
        echo "WARNUNG: /etc/environment enthält PPLX_API_KEY als Platzhalter."
        echo "  → Bitte Platzhalter manuell entfernen oder ersetzen."
        echo "  → Empfehlung: PPLX_API_KEY in /etc/environment entfernen,"
        echo "    stattdessen PERPLEXITY_API_KEY in ~/.bashrc oder .env nutzen."
    fi
fi

echo ""

# Nutzbaren Key wählen
if [[ $PXLX_OK -eq 1 ]]; then
    ACTIVE_KEY="$PXLX"
    echo "Aktiver Key: PERPLEXITY_API_KEY"
elif [[ $PPLX_OK -eq 1 ]]; then
    ACTIVE_KEY="$PPLX"
    echo "Aktiver Key: PPLX_API_KEY (Fallback)"
else
    echo "FEHLER: Kein gültiger Perplexity-Key gefunden."
    echo "Bitte PERPLEXITY_API_KEY in ~/.bashrc oder ~/.config/shadowmaker/shadowmaker.env setzen."
    exit 1
fi

echo ""

# Optionaler API-Test
if [[ "${1:-}" == "--test" ]]; then
    echo "=== API-Test ==="
    MODEL="${PERPLEXITY_MODEL:-sonar-pro}"
    echo "Modell: $MODEL"
    echo "Endpoint: https://api.perplexity.ai/chat/completions"

    RESPONSE=$(curl -s -o /tmp/pplx_test_response.json -w "%{http_code}" \
        -X POST "https://api.perplexity.ai/chat/completions" \
        -H "Authorization: Bearer ${ACTIVE_KEY}" \
        -H "Content-Type: application/json" \
        -d "{\"model\":\"${MODEL}\",\"messages\":[{\"role\":\"user\",\"content\":\"Antworte nur: OK\"}],\"max_tokens\":5}" \
        --max-time 15 2>/dev/null || echo "000")

    if [[ "$RESPONSE" == "200" ]]; then
        echo "API-Test: OK (HTTP 200)"
    elif [[ "$RESPONSE" == "401" ]]; then
        echo "API-Test: FEHLER — Key ungültig (401)"
    elif [[ "$RESPONSE" == "429" ]]; then
        echo "API-Test: Rate Limit (429) — Key funktioniert aber Limit erreicht"
    elif [[ "$RESPONSE" == "000" ]]; then
        echo "API-Test: Verbindungsfehler"
    else
        echo "API-Test: HTTP $RESPONSE"
    fi
    rm -f /tmp/pplx_test_response.json
fi

echo ""
echo "=== Status: Key verfügbar ==="
