#!/usr/bin/env bash

set -e
cwd="$(pwd)"
[ "$1" = '-i' ] || sh ~/.config/nvim/update.sh >/dev/null
cd ~ || exit
ARCH=$(uname -m)
. <(curl -fsSL 'https://raw.githubusercontent.com/Willie169/bashrc/refs/heads/main/bashrc.d/30-shared-functions.sh')
rm -f ~/.local/bin/superhtml || true
if [[ "$ARCH" == "x86_64" ]]; then
	SUPERHTML="x86_64-linux-musl"
else
	SUPERHTML="aarch64-linux"
fi
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' kristoff-it/superhtml "$SUPERHTML".tar.xz
xz -d "$SUPERHTML".tar.xz
tar -xf "$SUPERHTML".tar.xz
rm "$SUPERHTML".tar*
mv superhtml ~/.local/bin/
rm ~/.local/bin/verible* || true
if [[ "$ARCH" == "x86_64" ]]; then
	VERIBLE="verible-*-linux-static-x86_64"
elif [[ "$ARCH" == "aarch64" ]]; then
	VERIBLE="verible-*-linux-static-arm64"
fi
gh_latest -w --wget_option '--tries=100 --retry-connrefused --waitretry=5' chipsalliance/verible "$VERIBLE".tar.gz
# shellcheck disable=2086
tar -xzf $VERIBLE.tar.gz
mv verible*/bin/* ~/.local/bin/
rm -r verible*
mkdir eclipse.jdt.ls
cd eclipse.jdt.ls || exit
wget --tries=100 --retry-connrefused --waitretry=5 https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz -O jdt-language-server-latest.tar.gz
tar -xzf jdt-language-server-latest.tar.gz
rm jdt-language-server-latest.tar.gz*
cd ~ || exit
git clone --depth=1 https://codeberg.org/winlogon/ktlsp.git
cd ktlsp || exit
./gradlew :server:installDist
mv server/build/install/server/bin/kotlin-language-server ~/.local/bin/
cd ~ || exit
rm -rf ktlsp
# shellcheck disable=2164
cd "$cwd"
[ "$1" = '-i' ] || echo "Updated successfully!"
