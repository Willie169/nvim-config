#!/usr/bin/env bash

# GitHub Action termux/termux-docker errors to be prevented:
# + tar -xJf file.tar.xz
# tar: Unknown option Jf (see "tar --help")
# and
# + tar -xf -
# tar: chown ...: Operation not permitted
# use
# xz -d file.tar.xz
# tar -xf file.tar

set -e
cwd="$(pwd)"
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
[ "$ENV" -eq 2 ] && required=("apt" "cargo" "npm" "pkg" "uv") || required=("apt" "brew" "cargo" "cargo-binstall" "npm" "uv")
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
	PKG='clang gopls lua-language-server marksman neovim python3 python3-neovim texlab tree-sitter'
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
	[ -n "$PURGE" ] && DEBIAN_FRONTEND=noninteractive apt purge $PURGE -y -o Dpkg::Options::="--force-confnew"
	[ -n "$PKG" ] && DEBIAN_FRONTEND=noninteractive apt install $PKG -y -o Dpkg::Options::="--force-confnew"
	if ((${#apt_missing[@]})); then
		DEBIAN_FRONTEND=noninteractive apt install "${apt_missing[@]}" -y -o Dpkg::Options::="--force-confnew"
	fi
	command -v xz >/dev/null 2>&1 || DEBIAN_FRONTEND=noninteractive apt install xz-utils -y -o Dpkg::Options::="--force-confnew"
fi
if [ "$ENV" -ne 2 ]; then
	BREW='lua-language-server marksman neovim'
	# shellcheck disable=2086
	echo y | brew install $BREW || true
	# shellcheck disable=2086
	echo y | brew install $BREW
	npm config set allow-scripts=quick-lint-js --location=user
fi
npm i -g bash-language-server dockerfile-language-server-nodejs neovim pyright quick-lint-js vscode-json-languageserver yaml-language-server
for pkg in cmake-language-server jupytext; do
	uv tool install "$pkg"
done
curl -fsSL https://raw.githubusercontent.com/Willie169/nvim-config/refs/heads/main/full-update.sh | bash -- -i
# shellcheck disable=2164
cd "$cwd"
. <(curl -fsSL https://raw.githubusercontent.com/Willie169/nvim-config/refs/heads/main/install.sh)
