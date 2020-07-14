xrandr --listmonitors | awk 'BEGIN{count=0} NR>1 {count=count+1;split($3,a,"/");split(a[2],b,"x");print "MONITOR_"count"="$NF"\nHEIGHT_"count"="b[2]"\nWIDTH_"count"="a[1]"\n"}'
