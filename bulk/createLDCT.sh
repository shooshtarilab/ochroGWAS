#!/bin/bash

declare -a files=(~/scratch/ochrodbProject/data/NCLprocessedBED/*)

for t in "${files[@]}"; do
    declare noPathName="${t##*/}"
    declare noExt="${noPathName%.bed}"
    echo "$noExt"$'\t'~/scratch/ochrodbProject/data/NCLstep2again/"$noExt".
    
    # attach the following to the echo command above if using a compiled reference in processing
    #,~/scratch/ochrodbProject/data/NCLcompiledStep2/uniqueCompiledReference.

done > all.ldct

echo "done run"