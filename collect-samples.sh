#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-
SELFPATH="$(readlink -m "$0"/..)"


function main () {
  cd "$SELFPATH" || return $?

  local WGET_UA="$(LANG=C wget --version 2>&1 | head -n 1 | sed -nre '
    s~^.*\b([Ww]get) ([0-9\.]+) built on ([A-Za-z0-9-]+)\b.*$~\1/\2 (\3)~p')"
  local UA_OS='X11; Linux i686'
  UA_OS='Windows NT 6.1; WOW64'
  local OPERA_UA="Opera/9.80 ($UA_OS) Presto/2.12.388 Version/12.16"
  local FFOX_UA="Mozilla/5.0 ($UA_OS; rv:29.0) Gecko/20100101 Firefox/29.0"
  WGET_UA="$FFOX_UA"

  local SRV_BASE=http://api.recaptcha.net/
  local API_KEY='6LcqXMoSAAAAAKjuyEO6KOORNfLSiSU_ezGdQoBi'  # Hoaxilla-Forum
  local SAVE_FN=
  local API_HTML=
  local CHALLENGE=
  local IMG_URL=
  local IMG_NUM=
  local WGET_PID=
  local SAVE_STEM="$(date +%Y-%m%d-%H%M)"
  for IMG_NUM in $(seq 1 ${IMGCNT:-60}); do
    API_HTML="$(request_challenge)"
    WGET_PID="$(<<<"$API_HTML" grep -oPe '<!-- wget_pid=[0-9]+ -->' \
      | tail -n 1 | tr -cd 0-9)"
    SAVE_BFN="${SAVE_STEM}.$WGET_PID"
    IMG_URL="${SRV_BASE}$(<<<"$API_HTML" grep -oPe 'image\?[^\x22<>]+' \
      | tail -n 1)"
    save_pic &
  done
  wait

  return 0
}


function request_challenge () {
  get_saveas "${SRV_BASE}noscript?k=$API_KEY" - &
  local WGET_PID=$!
  wait "$WGET_PID"
  echo "<!-- wget_pid=$WGET_PID -->"
}


function save_pic () {
  local PIC_DEST="$SAVE_BFN".jpeg
  get_saveas "$IMG_URL" "$PIC_DEST" -q
  local CHALLENGE="$IMG_URL"
  CHALLENGE="${CHALLENGE##*\?}"
  CHALLENGE="${CHALLENGE##*=}"
  echo "<!-- challenge=${CHALLENGE} -->" >>"$PIC_DEST"
}


function get_saveas () {
  local SRC_URL="$1"; shift
  local DEST_FN="$1"; shift
  wget --user-agent="$WGET_UA" "$@" -O "$DEST_FN" "$SRC_URL"
}








main "$@"; exit $?
