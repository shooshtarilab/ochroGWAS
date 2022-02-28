#!/bin/bash
#SBATCH --time=8:00:00
#SBATCH --mem-per-cpu=30000M
#SBATCH --account=def-pshoosht

# initialize int array of 1-22. This is to accomodate chromosome numbers 1 to 22
vals=($(seq 1 1 22))

# performing these steps for each chromosome number
for val in ${vals[@]}; do
    echo $val
    
    # initialize list containing all different cell types in directory of BED files
    declare -a files=(~/scratch/ochrodbProject/data/NCLprocessedBED/*)
    
    # iterate through each cell type (aka BED file found in directory) and run `make_annot.py` from ldsc for each one
    for t in "${files[@]}"; do
        
        # get path name of file
        declare noPathName="${t##*/}"
        # get name of file without pathname and file extension
        declare noExt="${noPathName%.bed}"
        echo "$noExt"
        
        # run ldsc script
        python2 ~/scratch/ochrodbProject/ldsc/make_annot.py \
               --bed-file $t \
               --bimfile ~/scratch/ochrodbProject/data/hg38/extractedFiles/plink_files/1000G.EUR.hg38.$val.bim \
               --annot-file ~/scratch/ochrodbProject/data/NCLannotations/"$noExt".$val.annot
    done

done
