#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-
SELFPATH="$(readlink -m "$0"/..)"


function main () {
  cd "$SELFPATH" || return $?

  local SRV_BASE=http://api.recaptcha.net/
  local API_KEY='6LcqXMoSAAAAAKjuyEO6KOORNfLSiSU_ezGdQoBi'  # Hoaxilla-Forum
  local SAVE_FN=
  local API_HTML=
  local CHALLENGE=
  local IMG_URL=
  local IMG_NUM=
  local WGET_PID=
  local SAVE_STEM="$(date +%Y-%m%d-%H%M)"
  for IMG_NUM in {1..020}; do
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
  wget -O - "${SRV_BASE}noscript?k=$API_KEY" &
  local WGET_PID=$!
  wait "$WGET_PID"
  echo "<!-- wget_pid=$WGET_PID -->"
}


function save_pic () {
  local PIC_DEST="$SAVE_BFN".jpeg
  wget -q -O "$PIC_DEST" "$IMG_URL"
  local CHALLENGE="$IMG_URL"
  CHALLENGE="${CHALLENGE##*\?}"
  CHALLENGE="${CHALLENGE##*=}"
  echo "<!-- challenge=${CHALLENGE} -->" >>"$PIC_DEST"
}








main "$@"; exit $?
