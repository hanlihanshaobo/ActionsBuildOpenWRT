#!/bin/bash
# scripts/notify.sh
# 用法: bash notify.sh all "标题" "正文"

CHANNEL="$1"
TITLE="$2"
TEXT="$3"

send_dingtalk() {
  if [ "$ENABLE_DINGTALK" != "true" ]; then return; fi
  local timestamp=$(($(date +%s%N)/1000000))
  local string_to_sign="${timestamp}\n${DINGTALK_SECRET}"
  local sign=$(echo -n "$string_to_sign" | openssl dgst -sha256 -hmac "$DINGTALK_SECRET" -binary | base64 | jq -s -R -r @uri)

  curl -s -X POST "${DINGTALK_WEBHOOK_BASE}&timestamp=${timestamp}&sign=${sign}" \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg title "$TITLE" --arg text "$TEXT" '{msgtype:"markdown", markdown:{title:$title, text:$text}}')"
}

send_telegram() {
  if [ "$ENABLE_TELEGRAM" != "true" ]; then return; fi
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
    -d chat_id="$TELEGRAM_CHAT_ID" \
    -d parse_mode="Markdown" \
    -d text="*$TITLE*\n$TEXT"
}

send_wecom() {
  if [ "$ENABLE_WECOM" != "true" ]; then return; fi
  curl -s -X POST "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=${WECOM_KEY}" \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg content "*$TITLE*\n$TEXT" '{msgtype:"markdown", markdown:{content:$content}}')"
}

[ "$CHANNEL" = "dingtalk" ] && send_dingtalk
[ "$CHANNEL" = "telegram" ] && send_telegram
[ "$CHANNEL" = "wecom" ] && send_wecom
[ "$CHANNEL" = "all" ] && {
  send_dingtalk
  send_telegram
  send_wecom
}
