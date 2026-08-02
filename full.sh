#!/usr/bin/env bash

# GitHub Action termux/termux-docker errors to be prevented:
## + tar -xJf file.tar.xz
## tar: Unknown option Jf (see "tar --help")
## and
## + tar -xf -
## tar: chown ...: Operation not permitted
## use
## xz -dc file.tar.xz | tar -xf - || true

# TODO to readme
# Node.js provider
# Python 3 provider
# jupytext
# LSP list need checking
# clangd gopls bash-language-server dockerfile-language-server-nodejs neovim pyright cmake-language-server quick-lint-js vscode-json-languageserver superhtml texlab lua-language-server perl-lsp yaml-language-server rust-analyzer

# sort pkg by name

# TODO Termux

set -euxo pipefail
# ENV
# 0: normal
# 1: root
# 2: termux
ENV=0
[ "$EUID" -eq 0 ] && ENV=1
[ "${HOME}" = '/data/data/com.termux/files/home' ] && ENV=2
[ "${PREFIX}" = '/data/data/com.termux/files/usr' ] && ENV=2
cd ~ || exit
mkdir -p ~/.local/bin
[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
TMP_NVM_DIR="{NVM_DIR:-$HOME/.nvm}"
[ -s "$TMP_NVM_DIR/nvm.sh" ] && \. "$TMP_NVM_DIR/nvm.sh"
[ "$ENV" -eq 2 ] && required=("apt" "cargo" "npm" "uv") || required=("apt" "brew" "cargo" "npm" "uv")
missing=()
for cmd in "${required[@]}"; do
	if ! command -v -- "$cmd" >/dev/null 2>&1; then
		missing+=("$cmd")
	fi
done
if ((${#missing[@]})); then
	printf 'Error: missing required executables:\n' >&2
	printf '  %s\n' "${missing[@]}" >&2
	exit 1
fi
apt_required=("git" "wget" "curl" "unzip" "gzip" "tar" "bash")
apt_missing=()
for cmd in "${apt_required[@]}"; do
	if ! command -v -- "$cmd" >/dev/null 2>&1; then
		missing+=("$cmd")
	fi
done
if [ "$ENV" -eq 0 ]; then
	sudo apt update
elif [ "$ENV" -eq 1 ]; then
    apt update
else
    pkg update
fi
if [ "$ENV" -ne 2 ]; then
    PURGE='neovim tree-sitter-cli'
    PKG='clangd gopls python3 python3-neovim'
else
    PURGE=''
    PKG='clangd gopls lua-language-server neovim python3 python3-neovim texlab tree-sitter'
fi
# shellcheck disable=2086
if [ "$ENV" -eq 0 ]; then
	[ -n "$PURGE" ] && sudo DEBIAN_FRONTEND=noninteractive apt purge $PURGE -y -o Dpkg::Options::="--force-confnew"
	[ -n "$PKG" ] && sudo DEBIAN_FRONTEND=noninteractive apt install $PKG -y -o Dpkg::Options::="--force-confnew"
	if ((${#apt_missing[@]})); then
		sudo DEBIAN_FRONTEND=noninteractive apt install "${apt_missing[@]}" -y -o Dpkg::Options::="--force-confnew"
	fi
	command -v xz >/dev/null 2>&1 || sudo DEBIAN_FRONTEND=noninteractive apt install xz-utils -y -o Dpkg::Options::="--force-confnew"
else
	[ -n "$PURGE" ] && DEBIAN_FRONTEND=noninteractive apt plocal highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)urge $PURGE -y -o Dpkg::Options::="--force-confnew"
	[ -n "$PKG" ] && DEBIAN_FRONTEND=noninteractive apt install $PKG -y -o Dpkg::Options::="--force-confnew"
	if ((${#apt_missing[@]})); then
		DEBIAN_FRONTEND=noninteractive apt install "${apt_missing[@]}" -y -o Dpkg::Options::="--force-confnew"
	fi
	command -v xz >/dev/null 2>&1 || DEBIAN_FRONTEND=noninteractive apt install xz-utils -y -o Dpkg::Options::="--force-confnew"
fi
if [ "$ENV" -ne 2 ]; then
    BREW='lua-language-server neovim'
    # shellcheck disable=2086
    echo y | brew install $BREW || true
    # shellcheck disable=2086
    echo y | brew install $BREW
    echo 'yes' | cargo binstall tree-sitter-cli -y
    npm config set allow-scripts=quick-lint-js --location=user
cargo install --git https://github.com/latex-lsp/texlab
fi
npm i -g bash-language-server dockerfile-language-server-nodejs neovim pyright quick-lint-js vscode-json-languageserver yaml-language-server
for pkg in cmake-language-server jupytext; do
	uv tool install "$pkg"
done
. <(curl -fsSL 'https://raw.githubusercontent.com/Willie169/bashrc/refs/heads/main/bashrc.d/30-shared-functions.sh')
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
	gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' kristoff-it/superhtml x86_64-linux-musl.tar.xz
	xz -dc x86_64-linux-musl.tar.xz | tar -xf - || true
	rm x86_64-linux-musl.tar.xz*
	mv superhtml ~/.local/bin/
elif [[ "$ARCH" == "aarch64" ]]; then
	gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' kristoff-it/superhtml aarch64-linux.tar.xz
	xz -dc aarch64-linux.tar.xz | tar -xf - || true
	rm aarch64-linux.tar.xz*
	mv superhtml ~/.local/bin/
fi
cargo install perl-lsp
cargo install ra_ap_rust-analyzer
# https://github.com/chipsalliance/verible/releases arch if-else gh_latest b*c add
# https://github.com/eclipse-jdtls/eclipse.jdt.ls brew, termux?
# https://github.com/Kotlin/kotlin-lsp brew, termux?

curl -fsSL https://raw.githubusercontent.com/Willie169/nvim-config/refs/heads/main/install.sh | sh
