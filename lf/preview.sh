#!/bin/sh

draw() {
  ~/.config/lf/draw_img.sh "$@"
  exit 1
}

hash() {
  printf '%s/.cache/lf/%s' "$HOME" \
    "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
  if [ -f "$1" ]; then
    draw "$@"
  fi
}

file="$1"
shift

mime_type="$(file -Lb --mime-type -- "$file")"

case "$mime_type" in
application/zip)
  unzip -l "$file"
  ;;
application/x-tar)
  tar -tf "$file"
  ;;
application/x-bzip2)
  tar -tjf "$file"
  ;;
application/gzip)
  tar -tzf "$file"
  ;;
application/x-rar)
  unrar l "$file"
  ;;
text/*)
  highlight -O ansi -lVJ $3 "$file"
  ;;
application/pdf)
  cache=$(hash "$file")
  cache "$cache".jpg "$@"
  pdftoppm -jpeg -f 1 -singlefile "$file" "$cache"
  draw "$cache".jpg "$@"
  ;;
image/*)
  orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
  if [ -n "$orientation" ] && [ "$orientation" != 1 ]
  then
    cache="$(hash "$file").jpg"
    cache "$cache" "$@"
    convert -- "$file" -auto-orient "$cache"
    draw "$cache" "$@"
  else
    draw "$file" "$@"
  fi
  ;;
video/*)
  cache="$(hash "$file").jpg"
  cache "$cache" "$@"
  ffmpegthumbnailer -i "$file" -o "$cache" -s 0
  draw "$cache" "$@"
  ;;
*)
  file -Lb -- "$file" | fold -s -w $3
  #ffmpeg -i "$file" -f pulse default
  ;;
esac

exit 0
