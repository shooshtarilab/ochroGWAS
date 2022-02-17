#!/bin/bash
#SBATCH --time=4:00:00
#SBATCH --mem-per-cpu=8000M
#SBATCH --account=def-pshoosht

declare -a GWAS=("PASS_Alzheimer.sumstats" "PASS_Anorexia.sumstats" "PASS_Autism.sumstats" "PASS_BMI1.sumstats" "PASS_Bipolar_Disorder.sumstats"
                "PASS_Celiac.sumstats" "PASS_Coronary_Artery_Disease.sumstats" "PASS_Crohns_Disease.sumstats" "PASS_DS.sumstats"
                )


for t in "${GWAS[@]}"; do
    echo "$t"
    echo "${t%.*}"
    python2 ~/scratch/ochrodbProject/ldsc/ldsc.py \
        --h2-cts ~/scratch/ochrodbProject/data/sumStats/"$t" \
        --ref-ld-chr ~/scratch/ochrodbProject/data/hg38/baselineLD_v2.2/baselineLD. \
        --out ~/scratch/ochrodbProject/data/NCLstep3noref/gwasOutput"${t%.*}" \
        --ref-ld-chr-cts ~/scratch/ochrodbProject/scripts/revised/all.ldct \
        --w-ld-chr ~/scratch/ochrodbProject/data/hg38/weights_hm3_no_hla/weights.

done