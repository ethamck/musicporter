#!/bin/sh -
sed 's/#.*//' | sort | uniq | yt-dlp -O pre_process:"%(id)s	# %(track)s	%(artist)s" -a -
