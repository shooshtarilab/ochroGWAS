#!/bin/bash
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=80000M
#SBATCH --account=def-pshoosht
#SBATCH --array=1-4

# initiate array containing cell type names from BED directory
declare -a files=(~/scratch/ochrodbProject/data/NCLprocessedBED/*)

# run chromosome numbers for this SLURM job
val=${SLURM_ARRAY_TASK_ID}
echo $val

# iterate through cell types array, run ldsc script for each cell type
for t in "${files[@]}"; do
    echo "$t"
    echo ${SLURM_ARRAY_TASK_ID}
    
    # get file names and path names
    declare noPathName="${t##*/}"
    declare noExt="${noPathName%.bed}"
    echo "$noExt"
    
    # run ldsc script
    python2 ~/scratch/ochrodbProject/ldsc/ldsc.py \
           --l2 \
           --bfile \
           ~/scratch/ochrodbProject/data/hg38/extractedFiles/plink_files/1000G.EUR.hg38.$val \
           --ld-wind-cm 1 \
           --annot ~/scratch/ochrodbProject/data/NCLannotations/"$noExt".$val.annot \
           --thin-annot \
           --out ~/scratch/ochrodbProject/data/NCLstep2again/"$noExt".$val \
           --print-snps ~/scratch/ochrodbProject/data/hapmap3_snps/hm.$val.snp

done
