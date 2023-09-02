# musicporter

The main source of data every script interacts with is a **manifest file**, which is just a newline-delimited text file of IDs or URLs that `yt-dlp` can download. Comments (single-line `#`s) are filtered out.

Separate manifests can be used as playlists, but this is up to you. musicporter doesn't force any restrictions on the utility of the files.

Most scripts require `yt-dlp` and `ffmpeg` along with POSIX utilites. External dependencies are minimized.

Originally, musicporter only had `download.sh` (then named `porter.sh`) and was a large, bloated script I used to manually tag YouTube songs and move them to my phone. Since then it has been expanded into multiple simple and correct scripts as I need them.

See [my `manifest.tsv` file](https://gist.github.com/ethamck/701a8af65a8a83a46efca428760d436b) as an example of how I use these scripts.

## `play.sh`

Streams a random song as binary from manifest.

Interactively, you can use a one-line loop to play from your terminal in a shuffling fashion:

```sh
while true; do
	./play.sh manifest.tsv | mpv --really-quiet -
done
```

## `download.sh`

Downloads each song from manifest, tagging with song metadata and album art (from thumbnail). Useful for having a local copy of your library, especially on mobile devices.

The file format will default to the best quality, which is usually `.opus`.

## `add.sh`

Searches YouTube Music for a song and returns its formatted manifest line.

```
~ ./add.sh never gonna give you up
searching never+gonna+give+you+up
lYBUbBu4W08	# Never Gonna Give You Up	Rick Astley
```

Should be appended to a manifest file with `add.sh >> manifest.tsv`. Any content that displays on your terminal is from `stderr` and won't appear in the file.

After running this command, you may want to run `sort` on your manifest file to order it correctly.

## `format.sh`

Format a messy manifest file from scratch with track and artist names as comments.

Meant to be used with file redirection `format.sh > manifest.new`. (Don't overwrite the file that you're outputting stout to!)

Will take a long time on bigger files as it has to query metadata about every song. You don't need to use this if you use `add.sh` properly.

## `view.sh`

Displays your manifest file in table format (i.e., proper gaps between track and artist).

Requires that your manifest is formatted regularly (with `format.sh`) to render correctly. The default behavior is to dim the ID/URL and use the comment as regular text, while using tabs as column delimiters. You can hack this behavior and use your own comment format if you wish.

## `from/`

Import scripts. Converts a URL or local file to manifest format.

### `youtube.sh`

Outputs manifest based on YouTube playlist ID or URL. One of the scripts with the least overhead.

### `deezer.sh`

Requires `curl`, `jq`.

Input your user ID to download your favorite tracks. If you have more than 2000, the script will warn you that you need to concatenate each page manually (the API won't allow larger requests). If this case applies to you, the script also accepts a file path to operate upon instead of making a web request.
