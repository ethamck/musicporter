#!/bin/sh -
yt-dlp --no-simulate -O "[2mplaying %(id)s[m %(title)s" -qxf bestaudio -o - -- "$(sed 's/#.*//' | shuf -n1)"
