#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem-per-cpu=16000M
#SBATCH --account=def-pshoosht

vals=($(seq 1 1 22))

for val in ${vals[@]}; do
    echo $val
    declare -a files=(~/scratch/ochrodbProject/scATAC/data/scProcessedBed/*)

    for t in "${files[@]}"; do
        declare noPathName="${t##*/}"
        declare noExt="${noPathName%.bed}"
        echo "$noExt"
        python2 ~/scratch/ochrodbProject/ldsc/make_annot.py \
               --bed-file $t \
               --bimfile ~/scratch/ochrodbProject/data/hg19/1000G_EUR_Phase3_plink/1000G.EUR.QC.$val.bim \
               --annot-file ~/scratch/ochrodbProject/scATAC/newData/annotations/"$noExt".$val.annot
    done

done