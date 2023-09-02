#!/bin/sh -
yt-dlp -O "%(id)s	# %(track)s	%(artist)s" -- "$@"
