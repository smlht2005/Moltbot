# Moltbot

LINE Bot powered by Clawdbot + GitHub Copilot

## 📋 Setup Summary

### Prerequisites
- GitHub Codespaces
- LINE Developers Account
- GitHub Copilot access

### LINE Bot Info
- **Bot ID**: @776pxdbk
- **Display Name**: moltbot
- **Channel ID**: 2009006404

---

## 🚀 Setup Process

### 1. Enable LINE Plugin
```bash
clawdbot plugins enable line
```

### 2. Configure LINE Credentials
```bash
clawdbot config set channels.line.channelAccessToken "<YOUR_ACCESS_TOKEN>"
clawdbot config set channels.line.channelSecret "<YOUR_CHANNEL_SECRET>"
clawdbot config set channels.line.webhookPath "/line"
```

### 3. Start Gateway
```bash
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &
```

### 4. Configure Webhook in LINE Developers Console
- Go to: https://developers.line.biz/
- Navigate to your channel → Messaging API
- Set Webhook URL: `https://<YOUR_CODESPACE>-18789.app.github.dev/line`
- Enable "Use webhook"
- Click "Verify" to test

### 5. Make Port Public (Codespaces)
- Open PORTS panel in VS Code
- Find port `18789`
- Right-click → Port Visibility → **Public**

### 6. Approve User Pairing
When a user first messages the bot, they'll receive a pairing code:
```bash
clawdbot pairing approve line <PAIRING_CODE>
```

---

## 🔧 Troubleshooting

### Error: 502 Bad Gateway
**Cause**: Gateway not running  
**Solution**: Start the gateway
```bash
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &
```

### Error: 401 Unauthorized
**Cause**: Port is private in Codespaces  
**Solution**: Change port 18789 visibility to **Public** in PORTS panel

### Error: 405 Method Not Allowed
**Cause**: Wrong webhook path  
**Solution**: Set correct webhookPath
```bash
clawdbot config set channels.line.webhookPath "/line"
```

### Error: "access not configured"
**Cause**: User not approved  
**Solution**: Approve with pairing code
```bash
clawdbot pairing approve line <CODE>
```

### Error: 400 The requested model is not supported
**Cause**: AI model not available  
**Solution**: Switch to supported model
```bash
clawdbot config set agents.defaults.model.primary "github-copilot/gpt-4o"
# Restart gateway after changing model
clawdbot gateway stop
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &
```

---

## 📝 Useful Commands

| Command | Description |
|---------|-------------|
| `clawdbot gateway` | Start gateway (foreground) |
| `clawdbot gateway stop` | Stop gateway |
| `clawdbot gateway status` | Check gateway status |
| `clawdbot config get channels.line` | View LINE config |
| `clawdbot plugins list` | List plugins |
| `clawdbot models list` | List available AI models |
| `tail -f /tmp/gateway.log` | Monitor gateway logs |

---

## ⚠️ Notes

1. **Codespace Idle Timeout**: Gateway stops when Codespace is idle. Restart with `clawdbot gateway`.

2. **Webhook URL Changes**: If Codespace URL changes, update webhook in LINE Developers Console.

3. **Current Model**: `github-copilot/gpt-4o`

---

## 📅 Setup Date
January 29, 2026
