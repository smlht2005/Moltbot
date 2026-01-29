# Moltbot

LINE Bot powered by Clawdbot + GitHub Copilot

LINE 機器人，由 Clawdbot + GitHub Copilot 驅動

---

## 📋 Setup Summary | 設定摘要

### Prerequisites | 先決條件
- GitHub Codespaces
- LINE Developers Account | LINE 開發者帳號
- GitHub Copilot access | GitHub Copilot 存取權限

### LINE Bot Info | LINE Bot 資訊
- **Bot ID**: @776pxdbk
- **Display Name | 顯示名稱**: moltbot
- **Channel ID | 頻道 ID**: 2009006404

---

## 🚀 Setup Process | 設定流程

### 1. Enable LINE Plugin | 啟用 LINE 插件
```bash
clawdbot plugins enable line
```

### 2. Configure LINE Credentials | 設定 LINE 憑證
```bash
clawdbot config set channels.line.channelAccessToken "<YOUR_ACCESS_TOKEN>"
clawdbot config set channels.line.channelSecret "<YOUR_CHANNEL_SECRET>"
clawdbot config set channels.line.webhookPath "/line"
```

### 3. Start Gateway | 啟動閘道器
```bash
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &
```

### 4. Configure Webhook in LINE Developers Console | 在 LINE 開發者控制台設定 Webhook
- Go to | 前往: https://developers.line.biz/
- Navigate to your channel → Messaging API | 前往你的頻道 → Messaging API
- Set Webhook URL | 設定 Webhook URL: `https://<YOUR_CODESPACE>-18789.app.github.dev/line`
- Enable "Use webhook" | 啟用「Use webhook」
- Click "Verify" to test | 點擊「Verify」測試

### 5. Make Port Public (Codespaces) | 設定 Port 為公開 (Codespaces)
- Open PORTS panel in VS Code | 在 VS Code 開啟 PORTS 面板
- Find port `18789` | 找到 port `18789`
- Right-click → Port Visibility → **Public** | 右鍵 → Port Visibility → **Public**

### 6. Approve User Pairing | 核准使用者配對
When a user first messages the bot, they'll receive a pairing code:

當使用者第一次發訊息給 bot，會收到配對碼：
```bash
clawdbot pairing approve line <PAIRING_CODE>
```

---

## 🔧 Troubleshooting | 故障排除

### Error: 502 Bad Gateway
**Cause | 原因**: Gateway not running | 閘道器未運行  
**Solution | 解決方案**: Start the gateway | 啟動閘道器
```bash
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &
```

### Error: 401 Unauthorized
**Cause | 原因**: Port is private in Codespaces | Codespaces 的 Port 是私有的  
**Solution | 解決方案**: Change port 18789 visibility to **Public** in PORTS panel | 在 PORTS 面板將 port 18789 設為 **Public**

### Error: 405 Method Not Allowed
**Cause | 原因**: Wrong webhook path | 錯誤的 webhook 路徑  
**Solution | 解決方案**: Set correct webhookPath | 設定正確的 webhookPath
```bash
clawdbot config set channels.line.webhookPath "/line"
```

### Error: "access not configured"
**Cause | 原因**: User not approved | 使用者未核准  
**Solution | 解決方案**: Approve with pairing code | 使用配對碼核准
```bash
clawdbot pairing approve line <CODE>
```

### Error: 400 The requested model is not supported
**Cause | 原因**: AI model not available | AI 模型不可用  
**Solution | 解決方案**: Switch to supported model | 切換到支援的模型
```bash
clawdbot config set agents.defaults.model.primary "github-copilot/gpt-4o"
# Restart gateway after changing model | 更改模型後重啟閘道器
clawdbot gateway stop
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &
```

---

## 📝 Useful Commands | 常用指令

| Command | Description | 說明 |
|---------|-------------|------|
| `clawdbot gateway` | Start gateway (foreground) | 啟動閘道器（前景） |
| `clawdbot gateway stop` | Stop gateway | 停止閘道器 |
| `clawdbot gateway status` | Check gateway status | 檢查閘道器狀態 |
| `clawdbot config get channels.line` | View LINE config | 查看 LINE 設定 |
| `clawdbot plugins list` | List plugins | 列出插件 |
| `clawdbot models list` | List available AI models | 列出可用 AI 模型 |
| `tail -f /tmp/gateway.log` | Monitor gateway logs | 監控閘道器日誌 |

---

## ⚠️ Notes | 注意事項

1. **Codespace Idle Timeout | Codespace 閒置逾時**: Gateway stops when Codespace is idle. Restart with `clawdbot gateway`. | Codespace 閒置時閘道器會停止，需重新啟動。

2. **Webhook URL Changes | Webhook URL 變更**: If Codespace URL changes, update webhook in LINE Developers Console. | 如果 Codespace URL 改變，需在 LINE 開發者控制台更新 webhook。

3. **Current Model | 目前模型**: `github-copilot/gpt-4o`

---

## 📅 Setup Date | 設定日期
January 29, 2026 | 2026 年 1 月 29 日
