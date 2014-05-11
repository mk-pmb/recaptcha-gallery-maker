#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-
SELFPATH="$(readlink -m "$0"/..)"


function main () {
  cd "$SELFPATH" || return $?

  local TMPL_FN='mkgal.tmpl.html'
  local TMPL_MAXLN=9002
  local ENT_QUOT='"'
  local IMG_FNS="$(ls -1 20*.jpeg | grep -xPe '[0-9-]+\.[0-9-]+\.jpeg')"
  local IMG_TAGS="$(<<<"$IMG_FNS" sed -nre '
    s~^[0-9\.-]+\.jpeg$~a \\  <li><img src="&" alt=""></li>~p')"
  local IMG_GRPS=( $(<<<"$IMG_FNS" cut -d . -sf 1 | sort -u) )
  local IMG_GRP=
  local GRP_FN=
  local GRP_IMGS=

  for IMG_GRP in "${IMG_GRPS[@]}"; do
    GRP_FN="$IMG_GRP.html"
    echo -n "$GRP_FN: "
    if [ -s "$GRP_FN" ]; then
      echo 'exists, skip.'
      continue
    fi
    GRP_IMGS="$(<<<"$IMG_TAGS" grep -Fe "$ENT_QUOT$IMG_GRP.")"
    sed "$TMPL_FN" -re '
      s~\r~~g
      /id="imglist"/{
        '"$GRP_IMGS"'
      }' >"$GRP_FN"
    wc -l <<<"$GRP_IMGS"
  done

  return 0
}









main "$@"; exit $?
