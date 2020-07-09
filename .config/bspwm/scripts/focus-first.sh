#!/bin/bash
n=$(bspc query -N -n focused)
until bspc query -N -n ${n}.leaf; do
    n=$(bspc query -N -n ${n}#@1)
done
bspc node $n -f
