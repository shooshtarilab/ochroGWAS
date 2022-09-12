#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem-per-cpu=80000M
#SBATCH --account=def-pshoosht
#SBATCH --array=1-22

module load python/2.7
module bedtools/2.30.0
source ~/ENV/bin/activate

declare -a files=(~/bedfiles/*)											#address to .bed files

val=${SLURM_ARRAY_TASK_ID}
echo $val

for t in "${files[@]}"; do
    echo "$t"
    echo ${SLURM_ARRAY_TASK_ID}
    declare noPathName="${t##*/}"
    declare noExt="${noPathName%.bed}"
    echo "$noExt"
    python2 ~/ldsc/ldsc.py \											#address to ldsc.py script in ldsc package
           --l2 \
           --bfile \
           ~/plink/hg38/1000G.EUR.QC.$val \									#address to bfiles of PLINK
           --ld-wind-cm 1 \
           --annot ~/scratch/annots/"$noExt".$val.annot \							#address to annot files
           --thin-annot \
           --out ~/scratch/step2/"$noExt".$val \								#address to output
           --print-snps ~/hapmap3/w_hm3.snp									#address to hapmap3 snps

done
