#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-
SELFPATH="$(readlink -m "$0"/..)"


function main () {
  cd "$SELFPATH" || return $?

  local TMPL_FN='mkgal.tmpl.html'
  local TMPL_MAXLN=9002
  local ENT_QUOT='"'
  local IMG_FNS=( "$(ls -1 20*.jpeg | grep -xPe '[0-9-]+\.[0-9-]+\.jpeg')" )
  local IMG_GRPS=( $(<<<"$IMG_FNS" cut -d . -sf 1 | sort -u) )
  readarray -t IMG_FNS <<<"${IMG_FNS[0]}"
  local IMG_GRP=
  local GRP_FN=
  local GRP_IMGS=

  local IMG_LIST_MARKER='id="imglist"'
  for IMG_GRP in "${IMG_GRPS[@]}"; do
    GRP_FN="$IMG_GRP.html"
    echo -n "$GRP_FN: "
    if [ -s "$GRP_FN" ]; then
      echo 'exists, skip.'
      continue
    fi
    GRP_IMGS=0
    grep "$TMPL_FN" -Fe "$IMG_LIST_MARKER" -m 1 -B "$TMPL_MAXLN" \
      >"$GRP_FN" || return $?
    for IMG_FN in "${IMG_FNS[@]}"; do
      case "$IMG_FN" in
        "$IMG_GRP".* )
          render_img_base64_tag "$IMG_FN" >>"$GRP_FN" || return $?
          let GRP_IMGS="$GRP_IMGS+1"
          ;;
      esac
    done
    grep "$TMPL_FN" -Fe "$IMG_LIST_MARKER" -m 1 -A "$TMPL_MAXLN" \
      | tail -n +2 >>"$GRP_FN" || return $?
    echo "$GRP_IMGS"
  done

  return 0
}


function render_img_file_tag () {
  echo '<li><img src="'"$1"'" alt=""></li>'
}


function render_img_base64_tag () {
  local IMG_FN="$1"
  local CHAL_RGX='<!-- challenge='
  local IMG_B64="$(sed "$IMG_FN" -re 's~'"$CHAL_RGX.*$~~" | base64 --wrap=0)"
  local CHALLENGE="$(grep "$IMG_FN" -aoPe "$CHAL_RGX"'\S+' -m 1 \
    | cut -d = -sf 2-)"
  echo '<li><img src="data:image/jpeg;base64,'"$IMG_B64"'"' \
    'alt="'"$CHALLENGE"'"></li>'
}











main "$@"; exit $?
