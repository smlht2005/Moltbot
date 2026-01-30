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
- **Bot ID**: `@your_bot_id`
- **Display Name | 顯示名稱**: `your_bot_name`
- **Channel ID | 頻道 ID**: `your_channel_id`

---

## � LINE Channel Setup | LINE 頻道設定

### Step 1: Create LINE Developers Account | 步驟 1：建立 LINE 開發者帳號
1. Go to | 前往 https://developers.line.biz/
2. Log in with your LINE account | 使用 LINE 帳號登入
3. Create a new provider (e.g., "MyBot") | 建立新的 Provider（例如：「MyBot」）

### Step 2: Create Messaging API Channel | 步驟 2：建立 Messaging API 頻道
1. Click "Create a new channel" | 點擊「Create a new channel」
2. Select "Messaging API" | 選擇「Messaging API」
3. Fill in the required information | 填寫必要資訊：
   - Channel name | 頻道名稱
   - Channel description | 頻道說明
   - Category | 類別
   - Subcategory | 子類別
4. Agree to terms and create | 同意條款並建立

### Step 3: Get Credentials | 步驟 3：取得憑證
1. Go to "Basic settings" tab | 前往「Basic settings」分頁
   - Copy **Channel secret** | 複製 **Channel secret**
2. Go to "Messaging API" tab | 前往「Messaging API」分頁
   - Click "Issue" to generate **Channel access token** | 點擊「Issue」產生 **Channel access token**
   - Copy the token | 複製 token

### Step 4: Configure Messaging Settings | 步驟 4：設定訊息設定
In "Messaging API" tab | 在「Messaging API」分頁：
- **Auto-reply messages**: Disabled | **自動回覆訊息**：停用
- **Greeting messages**: Disabled (optional) | **問候訊息**：停用（可選）
- **Use webhook**: Enabled | **使用 webhook**：啟用

---

## �🚀 Setup Process | 設定流程

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
# 重要：使用 --bind lan 讓 Gateway 接受外部連接
# Important: Use --bind lan to allow external connections
nohup clawdbot gateway --bind lan > /tmp/gateway.log 2>&1 &
```

**可選：啟動自動重啟監控 | Optional: Start auto-restart monitor**
```bash
# 背景運行 keep-alive 腳本 | Run keep-alive script in background
nohup /workspaces/Moltbot/keep-alive.sh > /tmp/keep-alive.log 2>&1 &
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

## 🛠️ Troubleshooting | 故障排除

### 1. Gateway 停止運作 / Webhook 驗證失敗
**症狀**: LINE Webhook 驗證回傳 `404` 或 `502`，Bot 無法收到訊息。

**主要原因 (Root Cause)**:
- **綁定問題**: `clawdbot gateway` 預設僅監聽 `127.0.0.1` (localhost)，導致外部 LINE 伺服器無法存取。
- **休眠問題**: GitHub Codespaces 在閒置 30 分鐘後會進入休眠 (Hibernation)，導致所有背景進程 (Gateway) 被終止。

**解決方案**:
1. **正確綁定**: 啟動時必須加上 `--bind lan` 參數。
   ```bash
   clawdbot gateway --bind lan &
   ```
2. **自動啟動**: 項目已建立 `.devcontainer/devcontainer.json`，在 Codespace 重啟時會自動執行 Gateway。
3. **公開 Port**: 每次重啟後，請務必確認 **Port 18789** 的狀態為 **Public**。

### 2. Brave Search API 搜尋失效
**症狀**: Bot 回報沒有權限訪問搜尋引擎。

**解決方案**:
確保環境變數 `BRAVE_API_KEY` 已設定。
```bash
export BRAVE_API_KEY="your_api_key"
```
*(本項目已將 Key 加入 `~/.bashrc` 以利自動載入)*

---

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

---

## 🌐 Additional Features | 附加功能

### Browser Control & Web Search | 瀏覽器控制與網頁搜尋
查看 [BROWSER_SETUP.md](BROWSER_SETUP.md) 了解如何設置：
- 瀏覽器控制功能
- Brave Search API 網頁搜尋
- 即時資訊查詢

See [BROWSER_SETUP.md](BROWSER_SETUP.md) for setup instructions on:
- Browser control capabilities
- Brave Search API for web searches
- Real-time information queries

---

## 📅 Setup Date | 設定日期
January 29, 2026 | 2026 年 1 月 29 日
