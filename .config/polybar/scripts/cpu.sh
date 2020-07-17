#!/bin/env bash

useage=$(mpstat 1 1 | awk '/all/{print $4}')
memory=$(free -t | grep Mem | awk '{print $3/$2*100}')

useage=$(echo $useage  | awk '{print int($1+0.5)}')
memory=$(echo $memory | awk '{print int($1+0.5)}')

echo "%{F#dae1ec}%{T2}$useage%{T-}%{T3}%{O-13}$memory%{T-}%{F-}"
