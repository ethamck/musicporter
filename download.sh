#!/bin/sh -
sed 's/#.*//' "${1:-manifest.tsv}" | yt-dlp -qxf bestaudio --embed-metadata --embed-thumbnail --download-archive "${2:-.}/manifest.lock" --no-simulate -O pre_process:"[2mdownloading %(id)s[m" -O post_process:"[1A[K[2mdownloaded %(id)s[m %(title)s" -o "${2:-.}/%(id)s.%(ext)s" --progress -a -
