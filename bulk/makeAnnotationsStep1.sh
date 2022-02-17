#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem-per-cpu=30000M
#SBATCH --account=def-pshoosht

vals=($(seq 1 1 22))

for val in ${vals[@]}; do
    echo $val
    declare -a files=(~/scratch/ochrodbProject/data/NCLprocessedBED/*)

    for t in "${files[@]}"; do
        declare noPathName="${t##*/}"
        declare noExt="${noPathName%.bed}"
        echo "$noExt"
        python2 ~/scratch/ochrodbProject/ldsc/make_annot.py \
               --bed-file $t \
               --bimfile ~/scratch/ochrodbProject/data/hg38/extractedFiles/plink_files/1000G.EUR.hg38.$val.bim \
               --annot-file ~/scratch/ochrodbProject/data/NCLannotations/"$noExt".$val.annot
    done

done