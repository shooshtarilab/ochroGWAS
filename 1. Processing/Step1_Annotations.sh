#!/bin/bash
#SBATCH --time=03:00:00
#SBATCH --mem-per-cpu=16000M
#SBATCH --account=def-pshoosht

module load python/2.7
module load bedtools/2.30.0
source ~/ENV/bin/activate


vals=($(seq 1 1 22))

for val in ${vals[@]}; do
    echo $val
    declare -a files=(~/bedfiles/*)   						#The address to .bed files directory

    for t in "${files[@]}"; do
        declare noPathName="${t##*/}"
        declare noExt="${noPathName%.bed}"
        echo "$noExt"
        python2 ~/ldsc/make_annot.py \              				#address to make_annot.py within ldsc package
               --bed-file $t \
               --bimfile ~/plink/hg38/1000G.EUR.hg38.$val.bim \			#address to .bim files
               --annot-file ~/annots/"$noExt".$val.annot			#address to output of annots file directory
    done
done
