#!/bin/bash
# Problema 1
cut -d ',' -f 1-11,13-15 supervivents.csv > sortida1.csv

# Problema 2
awk -F ',' '{if ($14 == "False") print $0}' sortida1.csv > sortida.csv | awk -F ',' '{if ($14 == "video_error_or_removed") print $0}' sortida1.csv > sortida.csv 
A1=$(wc -l < sortida1.csv)
A2=$(wc -l < sortida.csv)
R=$(($A1-$A2))
echo $R "Registres han sigut eliminats"

# Problema 3
awk -F, 'BEGIN {OFS=","} 
{
    if (NF == 0) next;
    if (NR == 1) {
        print $0, "Ranking_Views"
    } else {
        if ($8 ~ /^[0-9]+$/) {
            if ($8 < 1000000) {
                print $0, "Bo"
            } else if ($8 >= 1000000 && $8 <= 10000000) {
                print $0, "Excel·lent"
            } else if ($8 > 10000000) {
                print $0, "Estrella"
            }
        } else {
            print $0, "False"
        }
    }
}' sortida.csv > sortidav.csv
