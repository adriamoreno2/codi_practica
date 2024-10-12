#!/bin/bash
# Problema 1
cut -d ',' -f 1-11,13-15 supervivents.csv > tall.csv

# Problema 2
awk -F ',' '{if ($14 == "False") print $0}' tall.csv > false.csv | awk -F ',' '{ if ($14 == "video_error_or_removed") print $0}' tall.csv > false.csv 

A1=$(wc -l < tall.csv)
A2=$(wc -l < false.csv)
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
}' false.csv > views.csv

# Problema 4
#!/bin/bash

echo "video_id,trending_date,title,channel_title,category_id,publish_time,tags,views,likes,dislikes,comment_count,Rlikes,Rdislikes" > rating.csv

while IFS=',' read -r video_id trending_date title channel_title category_id publish_time tags views likes dislikes comment_count
do
    if [[ "$video_id" == "video_id" ]]; then
        continue
    fi

    likes=$likes
    dislikes=$dislikes
    views=$views

    if [[ "$views" =~ ^[0-9]+$ ]] && [[ "$likes" =~ ^[0-9]+$ ]] && [[ "$dislikes" =~ ^[0-9]+$ ]] && [[ $views -gt 0 ]]; then
        rlikes=$(( (likes * 100) / views ))
        rdislikes=$(( (dislikes * 100) / views ))
    else
        rlikes=0
        rdislikes=0
    fi

    echo "$video_id,$trending_date,$title,$channel_title,$category_id,$publish_time,$tags,$views,$likes,$dislikes,$comment_count,$rlikes,$rdislikes" >> rating.csv

done < views.csv

