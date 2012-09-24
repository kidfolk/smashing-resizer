#!/bin/bash
# Edit the settings below:
output=("800 600" "1024 768" "1152 864" "1280 960" "1280 1024" "1400 1050" "1440 960" "1600 1200" "1920 1440" "1024 600" "1366 768" "1440 900" "1600 900" "1680 1050" "1280 800" "1920 1080" "1920 1200" "2560 1440" "2560 1600" "2880 1800")
default_src="src.jpg";
default_dst="%.jpg";
default_sign='y'
default_sig="sig.png";
default_gravity="center"
quality=100
# ======
# Do not edit below.
# ======
function math(){
  echo $(python -c "from __future__ import division; print $@")
}
function save(){
  local dst_w=${1}
  local dst_h=${2}
  local ratio=$(math $dst_w/$dst_h);
  local inter_w=$(math "int(round($src_h*$ratio))")
  local inter_h=${src_h}
  local size="${dst_w}x${dst_h}"
  echo "Saving ${size}..."
  #crop intermediate image (with target ratio)
  convert ${src} -gravity ${gravity} -crop ${inter_w}x${inter_h}+0+0 +repage temp.psd
  if [ "${sign}" == "y" ]; then
  convert temp.psd ${sig} -gravity southeast -geometry ${sig_w}x${sig_h}+24+48 -composite temp.psd
  fi

  local arguments="-interpolate bicubic -filter Lagrange"
  local unsharp="-unsharp 0.4x0.4+0.4+0.008"
  local current_w=${dst_w}
  while [ $(math "${current_w}/${dst_w} > 1.5") = "True" ]; do
    current_w=$(math ${current_w}\*0\.80)
    current_w=$(math "int(round(${current_w}))")
    arguments="${arguments} -resize 80% +repage ${unsharp} ${unsharp} ${unsharp} "
  done
  arguments="${arguments} -resize ${dst_w}x${dst_h}! +repage ${unsharp} ${unsharp} ${unsharp} -density 72x72 +repage"
  convert temp.psd ${arguments} -quality ${quality} ${dst/\%/${size}}
}
echo "Enter path to source image, or hit Enter to keep default value (${default_src}): "
read src
src=${src:-${default_src}}
echo "Enter destination path, or hit Enter to keep default value (${default_dst})."
echo "must include % symbol, it will be replaced by output size, f.e. '800x600'"
read dst
dst=${dst:-${default_dst}}
echo "Apply signature? (hit Enter for 'yes' or type 'n' for 'no') "
read sign
sign=${sign:-${default_sign}}
echo "Enter path to signature image, or hit Enter to keep default value (${default_sig}): "
read sig
sig=${sig:-${default_sig}}
echo "Enter gravity for cropping left/right edges (center, east, west), or hit Enter to keep default value (${default_gravity}): "
read gravity
gravity=${gravity:-${default_gravity}}

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
