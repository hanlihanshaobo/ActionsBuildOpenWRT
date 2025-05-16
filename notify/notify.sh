#!/bin/bash
# 通用通知脚本 notify.sh
# 支持钉钉、Telegram、企业微信

set -e

# --- 公共输入参数 ---
PLATFORM="${1:-dingtalk}"    # 通知平台：dingtalk | telegram | wecom
TITLE="${2:-通知标题}"       # 通知标题
TEXT="${3:-通知内容}"        # 通知正文（支持 Markdown）
TIME_NOW=$(TZ=Asia/Shanghai date "+%Y-%m-%d %H:%M:%S")

# --- 钉钉参数 ---
DINGTALK_WEBHOOK_BASE="${DINGTALK_WEBHOOK_BASE:-}"
DINGTALK_SECRET="${DINGTALK_SECRET:-}"

# --- Telegram 参数 ---
TELEGRAM_TOKEN="${TELEGRAM_TOKEN:-}"
TELEGRAM_CHAT_ID="${TELEGRAM_CHAT_ID:-}"

# --- 企业微信参数 ---
WECOM_KEY="${WECOM_KEY:-}"

# --- 公共正文模板 ---
MARKDOWN="### ${TITLE}%0A${TEXT}%0A- ⏰ 时间: ${TIME_NOW}"

send_dingtalk() {
  if [[ -z "$DINGTALK_WEBHOOK_BASE" || -z "$DINGTALK_SECRET" ]]; then
    echo "[钉钉] 缺少 DINGTALK_WEBHOOK_BASE 或 DINGTALK_SECRET" >&2
    return 1
  fi
  timestamp=$(($(date +%s%N)/1000000))
  string_to_sign="${timestamp}\n${DINGTALK_SECRET}"
  sign=$(echo -n "$string_to_sign" | openssl dgst -sha256 -hmac "$DINGTALK_SECRET" -binary | base64 | jq -s -R -r @uri)
  webhook="${DINGTALK_WEBHOOK_BASE}&timestamp=${timestamp}&sign=${sign}"

  body=$(jq -n \
    --arg title "$TITLE" \
    --arg text "$MARKDOWN" \
    '{msgtype:"markdown", markdown:{title:$title, text:$text}}')

  curl -s -X POST "$webhook" -H "Content-Type: application/json" -d "$body"
  echo "[钉钉] 已发送通知"
}

send_telegram() {
  if [[ -z "$TELEGRAM_TOKEN" || -z "$TELEGRAM_CHAT_ID" ]]; then
    echo "[Telegram] 缺少 TELEGRAM_TOKEN 或 TELEGRAM_CHAT_ID" >&2
    return 1
  fi

  text="*${TITLE}*\n${TEXT}\n\n⏰ 时间: ${TIME_NOW}"
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
    -d chat_id="${TELEGRAM_CHAT_ID}" \
    -d parse_mode="Markdown" \
    --data-urlencode text="$text"
  echo "[Telegram] 已发送通知"
}

send_wecom() {
  if [[ -z "$WECOM_KEY" ]]; then
    echo "[企业微信] 缺少 WECOM_KEY" >&2
    return 1
  fi

  webhook="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=${WECOM_KEY}"
  body=$(jq -n \
    --arg content "${TITLE}\n${TEXT}\n\n⏰ 时间: ${TIME_NOW}" \
    '{msgtype:"markdown", markdown:{content:$content}}')

  curl -s -X POST "$webhook" -H "Content-Type: application/json" -d "$body"
  echo "[企业微信] 已发送通知"
}

# --- 选择平台发送 ---
case "$PLATFORM" in
  dingtalk)
    send_dingtalk
    ;;
  telegram)
    send_telegram
    ;;
  wecom)
    send_wecom
    ;;
  *)
    echo "不支持的平台: $PLATFORM" >&2
    exit 1
    ;;
esac
