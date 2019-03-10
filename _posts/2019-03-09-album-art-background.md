---
layout: post
title: Album Art Desktop Background
---

I like seeing the album art of the song I'm listening on as my desktop background. My terminal setup
involves some level of transparency, and I find it interesting to see. For additional background,
I use the tiling desktop manager [i3](https://i3wm.org/) and terminal `urxvt`. Those aren't
relevant to the rest of this guide, but what is, is the fact that I use
[dunst](https://dunst-project.org/) to handle notifications. Set it first if you want to copy the
rest of this guide. I also use `nitrogen` to handle the desktop backgrounds, but I would expect this
to be possible with other environments as well, although I have not experimented there.

Components:

1. A music player that can send notifications
  - Spotify
  - Clementine
  - Probably others
2. `dunst`
3. `zsh`
4. `nitrogen`
5. `playerctl`

---

### Configure Music Player
Your music player needs to be configured to send notifications when songs change, and ideally,
when it pauses or starts again as well. This varies by application and version, so I won't explain
it thoroughly.

---

### Configure `dunst`

At the end of your `dunst` config, add a block like this example for Spotify:

```ini
[spotify]
    summary = "*"
    format = ""
    script = "~/scripts/song_change.sh"
    appname = "Spotify"
```

I don't know if the section name (`[spotify]`) matters, but the other fields instruct `dunst` to
match the relevant notifications (`summary` and `appname`), while `format` prevents you from
actually seeing the notification. If you do want to see song change notifications, you'll need to
modify that. Finally, the `script` field contains the location of the script next discussed.

---

### Song change script

```sh
#!/bin/zsh

IMAGE_CACHE_DIR="$HOME/.cache/biggerfisch_media_images"

function download_image() {
    if [[ ! -d "$IMAGE_CACHE_DIR" ]]; then
        mkdir -p "$IMAGE_CACHE_DIR"
    fi

    possible="$IMAGE_CACHE_DIR/$1"

    if [[ ! -f "$possible" ]]; then
        curl -s -q -L -o $possible "$2"
    fi

    echo "$possible"
    return "$?"
}

if [[ "$3" == "Paused" ]] || [[ "$3" == "Stopped" ]]; then
    nitrogen --restore
else
    url="$(playerctl metadata mpris:artUrl)"

    if [[ "$url" == "https://open.spotify.com"* ]]; then
        parts=("${(@s|/|)url}")
        short="$parts[-1]"
        url=$(download_image "$short" "$url")

    elif [[ "$url" == "file://"* ]]; then
        url="$(echo $url | cut -c 8-)"
    fi
    nitrogen --head=0 --set-zoom "$url"
fi
```

This script gets run by `dunst` when the song changes and handles acquiring (if needed) and setting
the background image. I know Clementine exposes a local file URI, while Spotify exposes a HTTPS URL
that redirects to the actual image. This script can handle both cases, the first directly, and the
latter by downloading the image to a cache directory and using that path.

Notes:
 - There is currently no handling for any path not existing
 - There are no current limits to the cache size/item count/etc. This will likely need to be
 addressed eventually, but Spotify's images are pretty low-res and small, so, not a priority.
 - This currently needs `zsh`, if only for the array and URL split. 
 - This currently needed a hardcoded display (`--head=0`), but I would like to make that dynamic
 in the future

---

### Summary Flow:

1. The media player sends a notification of song change, playback status change, etc.
2. `dunst` captures this notification and runs a script. Setting `format` to `""` stops the
notification from being displayed to the user
3. The script downloads the image, loads it from cache, or finds it on-disk and tells the background
manager to use it
