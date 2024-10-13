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
echo "video_id,trending_date,title,channel_title,category_id,publish_time,tags,views,likes,dislikes,comment_count,comments_disabled,ratings_disabled,video_error_or_removed,Ranking_Views,Rlikes,Rdislikes" > rating.csv

while IFS="," read -r video_id trending_date title channel_title category_id publish_time tags views likes dislikes comment_count comments_disabled ratings_disabled video_error_or_removed Ranking_Views; do

    if [[ "$video_id" == "video_id" ]]; then
        continue
    fi

    Rlikes=""
    Rdislikes=""

    if [[ -n "$likes" && "$likes" =~ ^[0-9]+$ ]] && [[ -n "$dislikes" && "$dislikes" =~ ^[0-9]+$ ]] && [[ -n "$views" && "$views" =~ ^[0-9]+$ ]]; then
        if [[ "$views" -gt 0 ]]; then
            Rlikes=$(( (likes * 100) / views ))
            Rdislikes=$(( (dislikes * 100) / views ))
        fi


        echo "$video_id,$trending_date,$title,$channel_title,$category_id,$publish_time,$tags,$views,$likes,$dislikes,$comment_count,$comments_disabled,$ratings_disabled,$video_error_or_removed,$Ranking_Views,$Rlikes,$Rdislikes" >> rating.csv
    else

        output_line=""
        for field in "$video_id" "$trending_date" "$title" "$channel_title" "$category_id" "$publish_time" "$tags" "$comment_count" "$comments_disabled" "$ratings_disabled" "$video_error_or_removed" "$Ranking_Views"; do
            if [[ -n "$field" ]]; then
                output_line+="$field,"
            fi
        done

        output_line=${output_line%,}
        echo "$output_line" >> rating.csv
    fi

done < views.csv
