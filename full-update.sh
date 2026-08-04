#!/usr/bin/env bash

set -euxo pipefail
cwd="${cwd:-$(pwd)}"
UPDATED=${UPDATED:-0}
if [ "$1" = '-i' ]; then
	UPDATED=1
fi
if [ "$UPDATED" -ne 1 ]; then
	sh ~/.config/nvim/update.sh -i
	UPDATED=1 . ~/.config/nvim/full-update.sh
	exit
fi
ENV=0
[ "${HOME}" = '/data/data/com.termux/files/home' ] && ENV=2
[ "${PREFIX:-}" = '/data/data/com.termux/files/usr' ] && ENV=2
cd ~ || exit
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
if [[ "$ARCH" == "x86_64" ]]; then
	SUPERHTML="x86_64-linux-musl"
else
	SUPERHTML="aarch64-linux"
fi
gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' kristoff-it/superhtml "$SUPERHTML".tar.xz
xz -d "$SUPERHTML".tar.xz
tar -xf "$SUPERHTML".tar
rm "$SUPERHTML".tar*
mv superhtml ~/.local/bin/
rm ~/.local/bin/verible* || true
if [[ "$ARCH" == "x86_64" ]]; then
	VERIBLE="verible-*-linux-static-x86_64"
elif [[ "$ARCH" == "aarch64" ]]; then
	VERIBLE="verible-*-linux-static-arm64"
fi
gh_release -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' chipsalliance/verible "$VERIBLE".tar.gz
# shellcheck disable=2086
tar -xzf $VERIBLE.tar.gz
mv verible*/bin/* ~/.local/bin/
rm -r verible*
rm -rf eclipse.jdt.ls || true
mkdir eclipse.jdt.ls
cd eclipse.jdt.ls || exit
wget --tries=100 --retry-connrefused --waitretry=5 https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz -O jdt-language-server-latest.tar.gz
tar -xzf jdt-language-server-latest.tar.gz
rm jdt-language-server-latest.tar.gz*
cd ~ || exit
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
