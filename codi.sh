#!/bin/bash
cut -d ',' -f 1-11,13-15 supervivents.csv > sortida1.csv
awk -F ',' '{if ($14 == "False") print $0}' sortida1.csv > sortida.csv | awk -F ',' '{if ($14 == "video_error_or_removed") print $0}' sortida1.csv > sortida.csv 
A1=$(wc -l < sortida1.csv)
A2=$(wc -l < sortida.csv)
R=$(($A1-$A2))
echo $R "Registres han sigut eliminats"

