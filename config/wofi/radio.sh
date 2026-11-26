#!/bin/sh

notification() {
  notify-send "Now Playing" "${1} ☕️🎶"
}

radio() {
  mpv --title=Radio "$@"
}

menu() {
  printf "01. News89.4\n"
  printf "02. Chillhop\n"
  printf "03. Box Lofi\n"
  printf "04. The Bootleg Boy\n"
  printf "05. Deep Space One\n"
  printf "06. SpaceStation\n"
  printf "07. GrooveSalad\n"
  printf "08. Real Roots Radio\n"
}

main() {
  choice=$(menu | wofi --dmenu --prompt "Radio Station" | cut -d. -f1)

  case "$choice" in
  01)
    notification "News89.4"
    radio --volume=70 "https://news894--di--nacs-ais-lgc--0a--cdn.cast.addradio.de/news894/live/mp3/high"
    ;;
  02)
    notification "Chillhop"
    radio --volume=50 "https://stream.zeno.fm/fyn8eh3h5f8uv"
    ;;
  03)
    notification "Box Lofi"
    radio --volume=50 "https://stream.zeno.fm/f3wvbbqmdg8uv"
    ;;
  04)
    notification "The Bootleg Boy"
    radio --volume=50 "https://stream.zeno.fm/0r0xa792kwzuv"
    ;;
  05)
    notification "Deep Space One"
    radio --volume=70 "https://ice5.somafm.com/deepspaceone-128-mp3"
    ;;
  06)
    notification "SpaceStation SOMA"
    radio --volume=70 "https://ice5.somafm.com/spacestation-128-mp3"
    ;;
  07)
    notification "Groove Salad"
    radio --volume=70 "https://ice5.somafm.com/groovesalad-128-mp3"
    ;;
  08)
    notification "Real Roots Radio"
    radio --volume=70 "https://streams.radio.co/s1df61e0af/listen"
    ;;
  esac
}

pkill -f 'mpv .*--title=Radio([[:space:]]|$)' || main
