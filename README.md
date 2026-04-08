# XIAO-MI-MIMO-CLAW

用于记忆我的 OpenClaw 记录

---

## 📋 聊天记录

### 2026-03-22 首次对话

#### 1. GitHub 仓库连接
- 用户发送了仓库地址：`git@github.com:y17875118460-art/XIAO-MI-MIMO-CLAW.git`
- 仓库为私有，需要 SSH 密钥访问
- 生成了 SSH 密钥对（ed25519），用户将公钥添加到 GitHub
- 配置了 `~/.ssh/config`，成功克隆仓库到本地

#### 2. 记忆同步
- 从仓库 `master` 分支读取了历史记录：
  - MEMORY.md（长期记忆）
  - USER.md（用户档案：杨金嵩，考研备考 + 健身计划）
  - memory/2026-03-22.md（日志）
- 将记录同步到本地 workspace

#### 3. 自动同步配置
- 在 HEARTBEAT.md 中配置了自动 git pull 同步
- 心跳时自动拉取仓库最新内容并同步到本地

#### 4. PDF 生成
- 用户要求重新生成个人计划日程表 PDF
- 原始脚本：`generate_plan_pdf.py`（学习和健身分开）
- 用户要求将学习和健身**合并**到每天的时间线中
- 新脚本：`generate_combined_pdf.py`
  - 彩色标签分类（🔴英语 🔵431 🟢396 🟠健身 ⚪上课 🟣休息）
  - 每天从早到晚的完整时间安排
  - 健身训练详情 + 分阶段规划

#### 5. 文件传输问题
- webchat 不支持直接发送文件
- 尝试了 HTTP 服务器下载（内网 IP 10.75.160.195:8899）
- 推送到 GitHub 仓库供用户下载

#### 6. Telegram 配置（待解决）
- 用户创建了 Telegram bot，配置了 bot token
- OpenClaw 重启后发现服务器连不上 Telegram API
- 原因：服务器在国内，Telegram 被墙（ETIMEDOUT）
- 解决方案：需要配置代理（VPN/机场）

#### 7. 微信方案
- OpenClaw 不支持微信（微信没有开放 bot API）
- 支持的渠道：Telegram、Discord、飞书、WhatsApp、Slack、Signal 等

---

## 📁 仓库文件说明

| 文件 | 说明 |
|------|------|
| README.md | 本文件，聊天记录与项目说明 |
| USER.md | 用户档案（考研计划、健身计划） |
| MEMORY.md | 长期记忆 |
| SOUL.md | AI 人格设定 |
| AGENTS.md | 工作规则与协议 |
| TOOLS.md | 本地工具配置 |
| IDENTITY.md | AI 身份信息 |
| HEARTBEAT.md | 心跳自动同步配置 |
| BOOTSTRAP.md | 首次引导脚本 |
| generate_plan_pdf.py | 原始 PDF 生成脚本（分开版） |
| generate_combined_pdf.py | 合并版 PDF 生成脚本 |
| memory/2026-03-22.md | 当日日志 |
| 个人计划日程表_杨金嵩.pdf | 个人计划日程表 PDF |

---

## 🔄 工作流程

1. 更新记忆文件（MEMORY.md、USER.md 等）
2. `git add -A && git commit && git push`
3. 心跳时自动 `git pull` 同步到本地
