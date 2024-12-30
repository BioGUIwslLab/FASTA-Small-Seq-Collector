#!/bin/bash

# Check if input arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_fasta> <output_fasta>"
    exit 1
fi

input_fasta=$1
output_fasta=$2

awk '/^>/ {if (seq) print seq; print; seq=""; next;} {seq=seq$0;} END {print seq;}' ${input_fasta} | \
awk 'NR%2==1 {header=$0} NR%2==0 {if(length($0) <= 300) {print header; print $0}}' | \
awk 'NR%2==1 {print $0} NR%2==0 {while(length($0) > 80) {print substr($0, 1, 80); $0 = substr($0, 81)} print $0}' > ${output_fasta}
