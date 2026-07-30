#!/usr/bin/env bash

shopt -s globstar
dir="$(cd -- "$(dirname -- "$0")" && pwd)"
echo '*
!.gitignore' >"$dir"/lua/plugins/.gitignore
for f in "$dir"/lua/plugins/*; do
	echo '!'"$(basename "$f")" >>"$dir"/lua/plugins/.gitignore
done
for f in "$dir"/**/*.lua; do
	stylua "$f"
done
