#!/bin/bash

input_tex="recipe.tex"
output_pdf="recipe.pdf"
output_prefix="recipe"
density=150
shadow="40x10+0+0"

lualatex "$input_tex"

gs -dNOPAUSE -dBATCH -sDEVICE=jpeg -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dJPEGQ=100 -r$density -sOutputFile="${output_prefix}-%d.jpg" "$output_pdf"

for img in ${output_prefix}-*.jpg; do
    base_name=$(basename "$img" .jpg)
    convert "$img" -background none \( +clone -background black -shadow $shadow \) +swap -background none -layers merge +repage "${base_name}.png"
    rm "$img"
done
