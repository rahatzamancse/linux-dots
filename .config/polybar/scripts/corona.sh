#! /bin/bash
COUNTRY="bangladesh"
URL="https://corona.lmao.ninja/v2/countries/$COUNTRY"
res=$(curl -sf "$URL")

if [ -z "$res" ]; then
	exit 1
fi

total_confirmed=$(jq '.cases' <<< $res)
total_deaths=$(jq '.deaths' <<< $res)

new_confirmed=$(jq '.todayCases' <<< $res)
new_death=$(jq '.todayDeaths' <<< $res)
new_recovered=$(jq '.todayRecovered' <<< $res)

echo "  $new_confirmed |  $new_death |  $new_recovered | 🆕 $total_confirmed | $total_deaths " > /tmp/corona-update
