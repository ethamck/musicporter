log() { echo "$@" >&2; }

if test -f "$1"; then
	DATA="$(cat $1)"
elif test "$1" != ""; then
	log [2mdownloading from api.deezer.com/user/$1...[m
	DATA="$(curl -s https://api.deezer.com/user/$1/tracks?limit=2147483647)"

	if test "$(echo $DATA | jq -Mrc 'has("next") or has("prev")')" = "true"; then
		log
		log Truncating to the first 2000 entries.
		log If you would like your entire favorites list to be copied over, manually download
		log
		log '\t'https://api.deezer.com/user/$1/tracks
		log
		log and combine each page listed at the end under \"next\", then combine each into a single JSON.
		log The result can be passed to this program instead of the user ID.
		log
	fi
else
	log No input provided.
	exit 1
fi

echo $DATA | jq -Mrc '.data[] | .artist.name + " - " + .title' | tr ' ' '+' | while read line; do
	log [2mquerying[m $line

	SONG="$(yt-dlp -iqS +size --max-downloads 1 "https://music.youtube.com/search?q=$line#songs" -O pre_process:"%(id)s"'\t'"%(track)s"'\t'"%(artist)s")"
	f() { echo $SONG | cut -f$1; }

	ID="$(f 1)"
	TITLE="$(f 2)"
	AUTHOR="$(f 3)"

	log [1A[K[2mwrote $ID[m $TITLE'\t'$AUTHOR
	echo $ID'\t# '$TITLE'\t'$AUTHOR
done

log "[5mprocessing finished.[m"
log "please check the file you've redirected to."
