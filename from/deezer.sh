if test -f "$1"; then
	DATA="$(cat $1)"
elif test "$1" != ""; then
	echo [2mdownloading from api.deezer.com/user/$1...[m
	DATA="$(curl -s https://api.deezer.com/user/$1/tracks?limit=2147483647)"

	if test "$(echo $DATA | jq -Mrc 'has("next") or has("prev")')" = "true"; then
		echo
		echo Truncating to the first 2000 entries.
		echo If you would like your entire favorites list to be copied over, manually download
		echo
		echo '\t'https://api.deezer.com/user/$1/tracks
		echo
		echo and combine each page listed at the end under \"next\", then combine each into a single JSON.
		echo The result can be passed to this program instead of the user ID.
		echo
	fi
else
	echo No input provided.
	exit 1
fi

echo $DATA | jq -Mrc '.data[] | .artist.name + " - " + .title' | tr ' ' '+' | while read line; do
	echo [2mquerying[m $line

	SONG="$(yt-dlp -iqS +size --max-downloads 1 "https://music.youtube.com/search?q=$line#songs" -O pre_process:"%(id)s"'\t'"%(track)s"'\t'"%(artist)s")"
	f() {echo $SONG | cut -f$1}

	ID="$(f 1)"
	TITLE="$(f 2)"
	AUTHOR="$(f 3)"

	echo [1A[K[2mwrote $ID[m $TITLE'\t'$AUTHOR
	echo $ID'\t# '$TITLE'\t'$AUTHOR >> $2
done

echo "[5mprocessing finished.[m"
echo "please inspect $2."
