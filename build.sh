#!/bin/bash
# Builds index.html from src/. Run it after editing anything in src/.
#
# The page is one file on purpose: the previous setup was ten separate
# repositories that drifted apart, so a correction meant seventeen edits in ten
# places. Here a correction is one edit, and a language can never 404.
set -euo pipefail
cd "$(dirname "$0")"

ORDER="en es pt fr de it ja ko zh-Hans zh-Hant"

{
    cat src/head.html
    for tag in $ORDER; do
        if [ -f "src/$tag.html" ]; then
            cat "src/$tag.html"
        else
            echo "  (missing: src/$tag.html)" >&2
        fi
    done
    cat src/tail.html
} > index.html

present=0
for tag in $ORDER; do [ -f "src/$tag.html" ] && present=$((present + 1)); done
printf 'index.html written — %d of 10 languages, %s\n' \
    "$present" "$(du -h index.html | cut -f1)"
