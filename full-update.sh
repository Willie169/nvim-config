#!/usr/bin/env bash

# GitHub Action termux/termux-docker possible errors to be prevented:
# + tar -xJf file.tar.xz
# tar: Unknown option Jf (see "tar --help")
# and
# + tar -xf -
# tar: chown ...: Operation not permitted
# use
# xz -d file.tar.xz
# gzip -d file.tar.gz
# tar -xf file.tar || true

set -euxo pipefail
cwd="${cwd:-$(pwd)}"
UPDATED=${UPDATED:-0}
if [ "${1:-}" = '-i' ]; then
	UPDATED=1
fi
if [ "$UPDATED" -ne 1 ]; then
	sh ~/.config/nvim/update.sh -i
	UPDATED=1 . ~/.config/nvim/full-update.sh
	exit
fi
ENV=0
[ "$EUID" -eq 0 ] && ENV=1
if [ "${HOME}" = '/data/data/com.termux/files/home' ] || [ "${PREFIX:-}" = '/data/data/com.termux/files/usr' ]; then
	ENV=2
fi
cd ~ || exit
if [ "$ENV" -eq 0 ]; then
	sudo luarocks install jsregexp
else
	luarocks install jsregexp
fi
if [ "$ENV" -ne 2 ]; then
	cargo-binstall tree-sitter-cli --no-confirm
	cargo install --git https://github.com/latex-lsp/texlab
fi
cargo install perl-lsp
if [ "$ENV" -ne 2 ]; then
	if [ "$1" = '-i' ]; then
		if ! cargo install ra_ap_rust-analyzer --force; then
			cargo install ra_ap_rust-analyzer --force
		fi
	else
		cargo install ra_ap_rust-analyzer
	fi
fi
ARCH=$(uname -m)
. <(curl -fsSL 'https://raw.githubusercontent.com/Willie169/bashrc/refs/heads/main/bashrc.d/30-shared-functions.sh')
rm -f ~/.local/bin/superhtml || true
if [[ "$ARCH" == "x86_64" || "$ARCH" == "amd64" ]]; then
	SUPERHTML="x86_64-linux-musl"
else
	SUPERHTML="aarch64-linux"
fi
gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' kristoff-it/superhtml "$SUPERHTML".tar.xz
xz -d "$SUPERHTML".tar.xz
tar -xf "$SUPERHTML".tar || true
rm "$SUPERHTML".tar*
mv superhtml ~/.local/bin/
rm ~/.local/bin/verible* || true
if [[ "$ARCH" == "x86_64" || "$ARCH" == "amd64" ]]; then
	VERIBLE="verible-*-linux-static-x86_64"
else
	VERIBLE="verible-*-linux-static-arm64"
fi
gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' chipsalliance/verible "$VERIBLE".tar.gz
# shellcheck disable=2086
gzip -d $VERIBLE.tar.gz
# shellcheck disable=2086
tar -xf $VERIBLE.tar || true
mv verible*/bin/* ~/.local/bin/
rm -r verible*
rm -rf eclipse.jdt.ls || true
mkdir eclipse.jdt.ls
cd eclipse.jdt.ls || exit
wget --tries=100 --retry-connrefused --waitretry=5 https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz -O jdt-language-server-latest.tar.gz
gzip -d jdt-language-server-latest.tar.gz
tar -xf jdt-language-server-latest.tar || true
rm jdt-language-server-latest.tar*
cd ~ || exit
test -f ~/eclipse.jdt.ls/bin/jdtls
rm -rf ktlsp || true
mkdir ktlsp
cd ktlsp
gh_release --codeberg winlogon/ktlsp server.zip
unzip server.zip
rm server.zip*
cd ~ || exit
# shellcheck disable=2164
cd "$cwd"
[ "$1" = '-i' ] || echo "Updated successfully!"
