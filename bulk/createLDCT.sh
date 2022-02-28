#!/bin/bash

# initiate array for cell types from BED directory
declare -a files=(~/scratch/ochrodbProject/data/NCLprocessedBED/*)

# for each cell type, echo out path names for the generated outputs from previous steps
for t in "${files[@]}"; do
    declare noPathName="${t##*/}"
    declare noExt="${noPathName%.bed}"
    echo "$noExt"$'\t'~/scratch/ochrodbProject/data/NCLstep2again/"$noExt".
    
    # attach the following to the echo command above if using a compiled reference in processing
    #,~/scratch/ochrodbProject/data/NCLcompiledStep2/uniqueCompiledReference.

# save all prints into file for use in step3
done > all.ldct

echo "done run"
