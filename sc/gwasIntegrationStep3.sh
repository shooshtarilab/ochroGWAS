#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --mem-per-cpu=8000M
#SBATCH --account=def-pshoosht

python2 ~/scratch/ochrodbProject/ldsc/ldsc.py \
    --h2-cts ~/scratch/ochrodbProject/data/sumStats/PASS_Rheumatoid_Arthritis.sumstats \
    --ref-ld-chr ~/scratch/ochrodbProject/data/hg19/baseline/baselineLD. \
    --out ~/scratch/ochrodbProject/scATAC/outputs/step3/gwasOutputRAbaselessCorrect \
    --ref-ld-chr-cts ~/scratch/ochrodbProject/scATAC/scripts/noRef.ldct \
    --w-ld-chr ~/scratch/ochrodbProject/data/hg19/weights_hm3_no_hla/weights.