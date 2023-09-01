sed 's/#.*//' "${1:-manifest.tsv}" | sort | uniq | yt-dlp -O pre_process:"%(id)s	# %(track)s	%(artist)s" -a -
