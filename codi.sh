#!/bin/bash
cut -d ',' -f 1-11,13-15 supervivents.csv > sortida1.csv
awk -F ',' '{if ($14 == "True") print $0}' sortida1.csv > sortida.csv
