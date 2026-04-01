# setup-vim.sh

一键安装 Vim 基础美化配置的 Shell 脚本，支持 macOS 和 Linux。

## 功能特性

- **自动检测并安装 Vim**：若系统未安装 Vim，自动调用 `brew` / `apt-get` / `yum` / `dnf` 安装
- **安全备份**：若已存在 `~/.vimrc`，自动备份（带时间戳），不会覆盖原有配置
- **一键写入配置**：生成包含以下功能的 `~/.vimrc`：
  - 行号 & 相对行号、当前行高亮、括号匹配高亮
  - 内置 `desert` 暗色主题 + 真彩色支持
  - 4 空格缩进（用空格替代 Tab）
  - 搜索高亮 & 实时搜索 & 大小写智能匹配
  - 自定义状态栏（文件路径 / 类型 / 行列号）
  - 系统剪贴板共享、鼠标支持、UTF-8 编码
- **语法校验**：写入后自动验证 `.vimrc` 无语法错误

## 快速开始

```bash
# 克隆仓库
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>

# 赋予执行权限并运行
bash setup-vim.sh
```

> 脚本需要在 Bash 环境下运行（`bash setup-vim.sh`），不支持 sh 直接执行。

## 安装后的快捷键

| 快捷键 | 说明 |
|--------|------|
| `jk` | 退出插入模式（替代 Esc） |
| `Ctrl+S` | 保存文件（普通模式 & 插入模式均可） |
| `Esc Esc` | 清除搜索高亮 |

## 生成的配置文件

脚本会向 `~/.vimrc` 写入以下配置项：

| 分类 | 配置 |
|------|------|
| 界面 | 行号、相对行号、光标行高亮、状态栏 |
| 主题 | `desert`（内置，无需插件），支持 termguicolors |
| 缩进 | 4 空格，expandtab，smartindent |
| 搜索 | hlsearch、incsearch、ignorecase + smartcase |
| 编辑 | UTF-8、系统剪贴板、鼠标支持、长行换行 |
| 文件 | 关闭备份文件和 swap 文件，自动重载 |

## 平台支持

| 平台 | 包管理器 |
|------|---------|
| macOS | Homebrew (`brew`) |
| Ubuntu / Debian | `apt-get` |
| CentOS / RHEL | `yum` |
| Fedora | `dnf` |

## 备份说明

若 `~/.vimrc` 已存在，脚本会在同目录生成带时间戳的备份：

```
~/.vimrc.bak.20240101_120000
```

如需恢复原配置：

```bash
cp ~/.vimrc.bak.<timestamp> ~/.vimrc
```

## License

MIT
