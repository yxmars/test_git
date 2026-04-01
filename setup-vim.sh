#!/usr/bin/env bash
# ==============================================================
# setup-vim.sh — Vim 基础美化配置一键安装脚本
# 支持：macOS / Linux
# 用法：bash setup-vim.sh
# ==============================================================

set -euo pipefail

# ---------- 颜色输出 ----------
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

info()    { echo -e "${GREEN}[INFO]${RESET}  $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; exit 1; }

# ---------- 检查 vim 是否安装 ----------
check_vim() {
    if ! command -v vim &>/dev/null; then
        warn "未检测到 vim，尝试自动安装..."
        if command -v brew &>/dev/null; then
            brew install vim
        elif command -v apt-get &>/dev/null; then
            sudo apt-get install -y vim
        elif command -v yum &>/dev/null; then
            sudo yum install -y vim
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y vim
        else
            error "无法自动安装 vim，请手动安装后重新运行脚本。"
        fi
    fi
    VIM_VERSION=$(vim --version | head -1)
    info "检测到 vim：$VIM_VERSION"
}

# ---------- 备份已有 .vimrc ----------
backup_vimrc() {
    local vimrc="$HOME/.vimrc"
    if [[ -f "$vimrc" ]]; then
        local backup="${vimrc}.bak.$(date +%Y%m%d_%H%M%S)"
        cp "$vimrc" "$backup"
        warn "已有 .vimrc 已备份至：$backup"
    fi
}

# ---------- 写入 .vimrc ----------
write_vimrc() {
    cat > "$HOME/.vimrc" << 'VIMRC'
" ===================================================
" Vim 基础美化配置
" ===================================================

" --- 基本设置 ---
set nocompatible            " 关闭 vi 兼容模式
filetype plugin indent on   " 开启文件类型检测
syntax on                   " 开启语法高亮

" --- 界面美化 ---
set number                  " 显示行号
set relativenumber          " 相对行号（方便跳转）
set cursorline              " 高亮当前行
set showmatch               " 高亮匹配括号
set ruler                   " 显示光标位置
set laststatus=2            " 始终显示状态栏
set showcmd                 " 在状态栏显示当前命令
set wildmenu                " 命令行补全增强
set scrolloff=5             " 光标距屏幕边缘保留 5 行

" --- 颜色主题 ---
set background=dark         " 使用暗色背景
colorscheme desert          " 使用内置 desert 主题（无需插件）

" 如果终端支持 256 色，开启真彩色
if has('termguicolors')
  set termguicolors
endif

" --- 缩进与格式 ---
set autoindent              " 自动缩进
set smartindent             " 智能缩进
set tabstop=4               " Tab 显示宽度
set shiftwidth=4            " 缩进宽度
set expandtab               " 用空格替代 Tab
set softtabstop=4           " 插入 Tab 时的宽度
set smarttab                " 智能 Tab

" --- 搜索 ---
set hlsearch                " 高亮搜索结果
set incsearch               " 实时搜索（输入时即时匹配）
set ignorecase              " 搜索忽略大小写
set smartcase               " 有大写字母时区分大小写

" --- 编辑体验 ---
set backspace=indent,eol,start  " 退格键可删除缩进/换行
set clipboard=unnamed           " 与系统剪贴板共享
set encoding=utf-8              " 文件编码
set fileencoding=utf-8
set wrap                        " 长行自动换行显示
set linebreak                   " 按单词边界换行

" --- 文件处理 ---
set nobackup                " 不生成备份文件
set noswapfile              " 不生成 swap 文件
set autoread                " 文件外部变更时自动重新加载

" --- 状态栏自定义 ---
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %F        " 文件路径
set statusline+=\ %m        " 修改标记
set statusline+=%#LineNr#
set statusline+=\ %y        " 文件类型
set statusline+=%=          " 右对齐分隔
set statusline+=%#CursorColumn#
set statusline+=\ %l/%L     " 当前行/总行数
set statusline+=\ %c\       " 列号

" --- 快捷键 ---
" 用 jk 代替 Esc 退出插入模式
inoremap jk <Esc>
" 取消搜索高亮
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" 保存文件
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" --- 鼠标支持 ---
set mouse=a                 " 开启鼠标支持
VIMRC
    info "已写入 ~/.vimrc"
}

# ---------- 校验配置是否有语法错误 ----------
validate_vimrc() {
    if vim -E -s -u "$HOME/.vimrc" +q 2>&1 | grep -q "^E"; then
        error ".vimrc 存在语法错误，请检查配置内容。"
    fi
    info ".vimrc 语法校验通过"
}

# ---------- 主流程 ----------
main() {
    echo ""
    echo "======================================================"
    echo "  Vim 基础美化配置 — 一键安装脚本"
    echo "======================================================"
    echo ""

    check_vim
    backup_vimrc
    write_vimrc
    validate_vimrc

    echo ""
    info "全部完成！配置已生效，直接打开 vim 即可体验。"
    echo ""
    echo "  配置文件位置：~/.vimrc"
    echo "  快捷键说明："
    echo "    jk       → 退出插入模式（替代 Esc）"
    echo "    Ctrl+S   → 保存文件"
    echo "    Esc Esc  → 清除搜索高亮"
    echo ""
}

main "$@"
