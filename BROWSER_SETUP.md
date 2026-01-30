# 瀏覽器與搜尋功能設置指南 | Browser & Search Setup Guide

本指南說明如何為 Moltbot 設置瀏覽器控制和網頁搜尋功能。

This guide explains how to set up browser control and web search capabilities for Moltbot.

---

## 📖 目錄 | Table of Contents

1. [瀏覽器控制設置 | Browser Control Setup](#browser-control)
2. [Brave Search API 設置 | Brave Search API Setup](#brave-search)
3. [使用方法 | Usage](#usage)
4. [故障排除 | Troubleshooting](#troubleshooting)

---

## <a id="browser-control"></a>🌐 瀏覽器控制設置 | Browser Control Setup

Clawdbot 內建瀏覽器控制功能，可以開啟網頁、截圖、操作網頁元素等。

Clawdbot has built-in browser control capabilities for opening pages, taking screenshots, and interacting with web elements.

### 1️⃣ 檢查瀏覽器狀態 | Check Browser Status

```bash
clawdbot browser status
```

### 2️⃣ 啟動瀏覽器 | Start Browser

瀏覽器會隨著 Gateway 自動啟動。確保 Gateway 正在運行：

The browser starts automatically with the Gateway. Ensure the Gateway is running:

```bash
# 檢查 Gateway 狀態 | Check Gateway status
clawdbot gateway status

# 如果未運行，啟動 Gateway | If not running, start Gateway
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &
```

### 3️⃣ 測試瀏覽器功能 | Test Browser Functions

```bash
# 開啟網頁 | Open a webpage
clawdbot browser open https://www.google.com

# 列出分頁 | List tabs
clawdbot browser tabs

# 截圖 | Take screenshot
clawdbot browser screenshot

# 獲取頁面快照 | Get page snapshot
clawdbot browser snapshot
```

---

## <a id="brave-search"></a>🔍 Brave Search API 設置 | Brave Search API Setup

Brave Search API 讓你的 bot 能夠進行網頁搜尋並獲取最新資訊。

Brave Search API enables your bot to perform web searches and get up-to-date information.

### 📝 步驟 1：註冊 Brave Search API | Step 1: Register for Brave Search API

1. **前往 Brave Search API 網站 | Visit Brave Search API Website**
   - URL: https://brave.com/search/api/

2. **建立帳號並申請 API Key | Create Account and Request API Key**
   - 點擊 "Get Started" 或 "Sign Up"
   - 填寫註冊資訊
   - 選擇適合的方案（有免費方案可用）
   - 獲取你的 API Key

### 🔑 步驟 2：配置 API Key | Step 2: Configure API Key

#### 方法 A：使用環境變數 | Method A: Using Environment Variables

```bash
# 設置環境變數 | Set environment variable
export BRAVE_API_KEY="your_api_key_here"

# 永久保存（加入到 ~/.bashrc 或 ~/.zshrc）| Make permanent (add to ~/.bashrc or ~/.zshrc)
echo 'export BRAVE_API_KEY="your_api_key_here"' >> ~/.bashrc
source ~/.bashrc
```

#### 方法 B：使用 Clawdbot 配置 | Method B: Using Clawdbot Config

```bash
# 設置 Brave API Key
clawdbot config set credentials.brave.apiKey "your_api_key_here"
```

#### 方法 C：為當前 Codespace 設置 | Method C: For Current Codespace

在 GitHub Codespaces 中，你可以將 API Key 設置為 secret：

In GitHub Codespaces, you can set the API Key as a secret:

1. 前往你的 GitHub repository
2. Settings → Secrets and variables → Codespaces
3. 新增 secret: `BRAVE_API_KEY`
4. 重啟 Codespace

### 🔧 步驟 3：驗證設置 | Step 3: Verify Setup

```bash
# 檢查環境變數 | Check environment variable
echo $BRAVE_API_KEY

# 或檢查配置 | Or check config
clawdbot config get credentials.brave.apiKey
```

### 🎯 步驟 4：使用搜尋功能 | Step 4: Use Search Function

重啟 Gateway 以載入新配置：

Restart Gateway to load new configuration:

```bash
# 停止 Gateway | Stop Gateway
clawdbot gateway stop

# 啟動 Gateway | Start Gateway
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &
```

現在你的 bot 應該可以進行網頁搜尋了！

Now your bot should be able to perform web searches!

---

## <a id="usage"></a>💬 使用方法 | Usage

### 在 LINE 中使用搜尋 | Using Search in LINE

當使用者在 LINE 中詢問需要最新資訊的問題時，bot 會自動使用 Brave Search：

When users ask questions requiring up-to-date information in LINE, the bot will automatically use Brave Search:

**示例 | Examples:**
- "台灣今天的新聞" (Taiwan's news today)
- "最新的 AI 技術發展" (Latest AI technology developments)
- "今天的股市表現" (Today's stock market performance)
- "即時天氣預報" (Real-time weather forecast)

### 使用瀏覽器功能 | Using Browser Functions

bot 也可以執行瀏覽器相關任務：

The bot can also perform browser-related tasks:

**示例 | Examples:**
- "開啟 Google" (Open Google)
- "截圖這個網頁" (Screenshot this webpage)
- "查看這個網站的內容" (View this website's content)

---

## <a id="troubleshooting"></a>🔧 故障排除 | Troubleshooting

### 問題 1：找不到 Brave Search 權限 | Issue 1: No Brave Search Permission

**錯誤訊息 | Error Message:**
```
抱歉，我没有权限访问 Brave 搜索引擎进行查询。
```

**解決方案 | Solution:**
1. 確認 API Key 已正確設置
2. 重啟 Gateway
3. 檢查 API Key 的配額和有效性

```bash
# 檢查配置 | Check configuration
clawdbot config get credentials.brave.apiKey

# 重設配置 | Reset configuration
clawdbot config set credentials.brave.apiKey "your_new_api_key"

# 重啟 Gateway | Restart Gateway
clawdbot gateway stop
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &
```

### 問題 2：瀏覽器無法連接 | Issue 2: Browser Connection Refused

**錯誤訊息 | Error Message:**
```
Error: Can't reach the clawd browser control server
```

**解決方案 | Solution:**

```bash
# 1. 確認 Gateway 正在運行 | Ensure Gateway is running
clawdbot gateway status

# 2. 如果未運行，啟動它 | If not running, start it
nohup clawdbot gateway > /tmp/gateway.log 2>&1 &

# 3. 等待幾秒後測試瀏覽器 | Wait a few seconds then test browser
sleep 5
clawdbot browser status
```

### 問題 3：API Key 無效 | Issue 3: Invalid API Key

**可能原因 | Possible Causes:**
- API Key 輸入錯誤
- API Key 已過期
- 配額用完

**解決方案 | Solution:**
1. 登入 Brave Search API Dashboard 確認 Key 狀態
2. 生成新的 API Key
3. 更新配置並重啟

### 問題 4：搜尋結果為空 | Issue 4: Empty Search Results

**檢查項目 | Check:**
```bash
# 查看 Gateway 日誌 | Check Gateway logs
tail -f /tmp/gateway.log

# 測試網路連接 | Test network connection
curl https://api.search.brave.com/res/v1/web/search?q=test \
  -H "X-Subscription-Token: $BRAVE_API_KEY"
```

---

## 📚 相關資源 | Related Resources

- **Brave Search API 文檔** | Brave Search API Documentation  
  https://brave.com/search/api/

- **Clawdbot 官方文檔** | Clawdbot Official Documentation  
  https://docs.clawd.bot/

- **Clawdbot Browser 文檔** | Clawdbot Browser Documentation  
  https://docs.clawd.bot/cli/browser

---

## 🎓 進階配置 | Advanced Configuration

### 配置搜尋參數 | Configure Search Parameters

你可以自訂搜尋行為：

You can customize search behavior:

```bash
# 設置搜尋語言 | Set search language
clawdbot config set search.brave.language "zh-TW"

# 設置搜尋地區 | Set search region
clawdbot config set search.brave.country "TW"

# 設置結果數量 | Set result count
clawdbot config set search.brave.count 10
```

### 啟用其他搜尋引擎 | Enable Other Search Engines

Clawdbot 也支援其他搜尋工具（如果可用）：

Clawdbot also supports other search tools (if available):

```bash
# 檢查可用的搜尋技能 | Check available search skills
clawdbot skills list | grep -i search

# 安裝額外的搜尋技能 | Install additional search skills
npx clawdhub install <skill-name>
```

---

## ✅ 快速檢查清單 | Quick Checklist

設置完成後，確認以下項目：

After setup, verify the following:

- [ ] Gateway 正在運行 | Gateway is running
- [ ] 瀏覽器狀態正常 | Browser status is OK
- [ ] Brave API Key 已配置 | Brave API Key is configured
- [ ] 環境變數已設置（如使用）| Environment variables are set (if using)
- [ ] Gateway 已重啟以載入配置 | Gateway restarted to load config
- [ ] 在 LINE 中測試搜尋功能 | Search function tested in LINE

---

## 💡 使用技巧 | Pro Tips

1. **定期檢查 API 配額** | Regularly check API quota  
   登入 Brave API Dashboard 監控使用量

2. **使用精確的搜尋關鍵字** | Use precise search keywords  
   更精確的問題會得到更好的搜尋結果

3. **結合瀏覽器和搜尋** | Combine browser and search  
   可以先搜尋再用瀏覽器開啟特定網站

4. **監控日誌** | Monitor logs  
   使用 `tail -f /tmp/gateway.log` 查看搜尋請求

---

**最後更新 | Last Updated**: January 29, 2026  
**版本 | Version**: 1.0
