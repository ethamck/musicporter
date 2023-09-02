#!/bin/sh -
sed 's/#.*//' | yt-dlp -qxf bestaudio --embed-metadata --embed-thumbnail --download-archive "${1:-.}/manifest.lock" --no-simulate -O pre_process:"[2mdownloading %(id)s[m" -O post_process:"[1A[K[2mdownloaded %(id)s[m %(title)s" -o "${1:-.}/%(id)s.%(ext)s" --progress -a -
