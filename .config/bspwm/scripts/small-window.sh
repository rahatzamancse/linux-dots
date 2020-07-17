#!/bin/bash

while read -r _ _ _ _ wid; do
    sizes=($(bspc query -T -n "$wid.tiled" | jq -r '
        .client | .floatingRectangle, .tiledRectangle | "\(.width) \(.height)"
    '))
    (( "${#sizes[@]}" == 4 )) \
        || continue
    (( sizes[0] < $threshold_width \
    || sizes[1] < $threshold_height \
    || sizes[2] < $minimum_tile_width \
    || sizes[3] < $minimum_tile_height )) \
        && bspc node "$wid" -t floating
done

