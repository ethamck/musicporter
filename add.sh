>&2 echo [2msearching[m $(echo $@ | tr ' ' '+')
yt-dlp -qi --max-downloads 1 "https://music.youtube.com/search?q=$(echo $@ | tr ' ' '+')#songs" -O "%(id)s	# %(track)s	%(artist)s"
