#!/bin/bash


declare -a files=(~/scratch/ochrodbProject/scATAC/newData/scProcessedBed/*)

for t in "${files[@]}"; do
    declare noPathName="${t##*/}"
    declare noExt="${noPathName%.bed}"
    echo "$noExt"$'\t'~/scratch/ochrodbProject/scATAC/outputs/step2/"$noExt".
    #,~/scratch/ochrodbProject/scATAC/outputs/referenceStep2/scCompiledReferenceModded.

# uncomment the above if compiled reference is used
done > noRef.ldct

echo "done run"
