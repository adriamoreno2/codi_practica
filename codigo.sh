!/bin/bash
cut -d ',' -f 1,2,3,4,5,6,7,8,9,10,11,13,14,15 supervivents.csv
awk -F ',' '{if ($15 == True) cut}'
