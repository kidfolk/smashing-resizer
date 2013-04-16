#!/bin/bash
# Edit the settings below:
output=("64 64" "48 48" "32 32")
default_src="src.png";
default_dst="%.png";
# ======
# Do not edit below.
# ======

function save(){
  local dst_w=${1}
  local dst_h=${2}
  local size="${dst_w}x${dst_h}"
  echo "Saving ${size}..."
  

  convert ${src} -resize ${dst_w}x${dst_h} ${dst/\%/${size}}
}
echo "Enter path to source image, or hit Enter to keep default value (${default_src}): "
read src
src=${src:-${default_src}}
echo "Enter destination path, or hit Enter to keep default value (${default_dst})."
echo "must include % symbol, it will be replaced by output size, f.e. '800x600'"
read dst
dst=${dst:-${default_dst}}

src_w=$(identify -format "%w" "${src}")
src_h=$(identify -format "%h" "${src}")
if [ "${sign}" == "y" ]; then
  sig_w=$(identify -format "%w" "${sig}")
  sig_h=$(identify -format "%h" "${sig}")
fi
for i in "${output[@]}"
do
  save ${i}
done
rm temp.psd
echo "Done!"
