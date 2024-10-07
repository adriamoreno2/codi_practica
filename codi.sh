#!/bin/bash
cut -d ',' -f 12 --complement in supervivents1.csv
cut -d ',' -f 16 --complement in supervivents1.csv

awk -F, '{if ($15 == "True") cut}'

awk -F
