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
# tree sitter neovim use apt

set -euxo pipefail
cd ~ || exit
mkdir -p ~/.local/bin
[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
TMP_NVM_DIR="{NVM_DIR:-$HOME/.nvm}"
[ -s "$TMP_NVM_DIR/nvm.sh" ] && \. "$TMP_NVM_DIR/nvm.sh"
required=("apt" "brew" "cargo" "npm" "uv")
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
[ "$EUID" -eq 0 ] && ROOT=1
PURGE='neovim tree-sitter-cli'
PKG='clangd gopls python3 python3-neovim'
apt_required=("git" "wget" "curl" "unzip" "gzip" "tar" "bash")
apt_missing=()
for cmd in "${apt_required[@]}"; do
	if ! command -v -- "$cmd" >/dev/null 2>&1; then
		missing+=("$cmd")
	fi
done
# shellcheck disable=2086
if [ "$ROOT" -eq 0 ]; then
	sudo apt update
	sudo DEBIAN_FRONTEND=noninteractive apt purge $PURGE -y -o Dpkg::Options::="--force-confnew"
	sudo DEBIAN_FRONTEND=noninteractive apt install $PKG -y -o Dpkg::Options::="--force-confnew"
	if ((${#apt_missing[@]})); then
		sudo DEBIAN_FRONTEND=noninteractive apt install "${apt_missing[@]}" -y -o Dpkg::Options::="--force-confnew"
	fi
	command -v xz >/dev/null 2>&1 || sudo DEBIAN_FRONTEND=noninteractive apt install xz-utils -y -o Dpkg::Options::="--force-confnew"
else
	apt update
	DEBIAN_FRONTEND=noninteractive apt purge $PURGE -y -o Dpkg::Options::="--force-confnew"
	DEBIAN_FRONTEND=noninteractive apt install $PKG -y -o Dpkg::Options::="--force-confnew"
	if ((${#apt_missing[@]})); then
		DEBIAN_FRONTEND=noninteractive apt install "${apt_missing[@]}" -y -o Dpkg::Options::="--force-confnew"
	fi
	command -v xz >/dev/null 2>&1 || DEBIAN_FRONTEND=noninteractive apt install xz-utils -y -o Dpkg::Options::="--force-confnew"
fi
# termux apt lua-language-server
BREW='lua-language-server neovim'
# shellcheck disable=2086
echo y | brew install $BREW || true
# shellcheck disable=2086
echo y | brew install $BREW
echo 'yes' | cargo binstall tree-sitter-cli -y
npm config set allow-scripts=quick-lint-js --location=user
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
# termux use apt install texlab
cargo install --git https://github.com/latex-lsp/texlab
cargo install perl-lsp
cargo install ra_ap_rust-analyzer
# https://github.com/chipsalliance/verible/releases arch if-else gh_latest b*c add
# https://github.com/eclipse-jdtls/eclipse.jdt.ls brew, termux?
# https://github.com/Kotlin/kotlin-lsp brew, termux?
