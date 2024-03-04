#!/bin/bash
# generate darksands theme for different languages
# Usage: gen.sh [-w|[language]]
#  -w   write all the themes to files

declare -A DARKSANDS=(
  [COLOR_ACCENT]="ffd5a0"
  [COLOR_TEXT]="C2BAB2"

  [COLOR_OK]="89b482"
  [COLOR_PINK]="d3869b"

  [COLOR_ERROR]="ea6962"
  [COLOR_WARN]="e78a4e"
  [COLOR_INFO]="7daea3"

  [COLOR_LAYER0]="191817"
  [COLOR_LAYER1]="232020"
  [COLOR_LAYER2]="2b2828"
  [COLOR_LAYER3]="353232"
  [COLOR_LAYER4]="3f3c3c"
  [COLOR_LAYER5]="4a4747"
)


rust ()
{
  for name in ${!DARKSANDS[@]} ; do
    echo "const $name :u32 = 0x${DARKSANDS[$name]}00_u32"
  done
}

lua (){
  echo "local darksands={"
  for name in ${!DARKSANDS[@]} ; do
    echo "  $name=\"#${DARKSANDS[$name]}\","
  done
  echo "}"
}

ohmyposh (){
  echo "\"palette\":{"
  for name in ${!DARKSANDS[@]} ; do
    echo "  \"$name\":\"#${DARKSANDS[$name]}\","
  done
  echo "}"
}

css () {
  echo "html {"
  for name in ${!DARKSANDS[@]} ; do
    echo "  --$name:#${DARKSANDS[$name]};"
  done
  echo "}"
}

yambar (){
  echo ".darksands:"
  i=0
  for name in ${!DARKSANDS[@]} ; do
    echo "  $i: &$name: ${DARKSANDS[$name]}"
    i=$((i+1))
  done
}

shell (){
  for name in ${!DARKSANDS[@]} ; do
    echo "export $name=\"${DARKSANDS[$name]}\""
  done
}

if [ "$1" = "-w" ] ; then
  lua > darksands.lua
  rust > darksands.rs
  shell > darksands.sh
  ohmyposh > darksands_ohmyposh.json
  css > darksands.css
  yambar > darksands_yambar.yml
  exit 0
fi

if [ "$1" = "" ] ; then
  lua
  rust
  shell
  ohmyposh
  css
  yambar
  exit 0
fi

$1