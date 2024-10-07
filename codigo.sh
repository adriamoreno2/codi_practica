#!/bin/bash
cut -d ',' -f 1,2,3,4,5,6,7,8,9,10,11,13,14,15 supervivents.csv > arxiu1.csv
X=$(wc -l < arxiu1.csv)
awk -F ',' '{if ($14 == "False") print $0}' arxiu1.csv > arxiu2.csv
Y=$(wc -l <arxiu2.csv)
Z=$(($X-$Y-1))
echo $Z
