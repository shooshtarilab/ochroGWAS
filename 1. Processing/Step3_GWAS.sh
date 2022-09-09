#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --mem-per-cpu=8000M
#SBATCH --account=def-pshoosht

module load python/2.7
module load bedtools/2.30.0
source ~/ENV/bin/activate

declare -a files=(~/scratch/trial/*.sumstats)										#address to sumstats of phenotypes

for t in "${files[@]}"; do
	echo "$t"
	python2 ~/ldsc/ldsc.py \											#address to ldsc.py of LDSC package
		--h2-cts "$t" \
		--ref-ld-chr ~/baseline/hg38/baselineLD. \								#address to baseline LD
    		--out ~/scratch/step3 \											#address to output folder
    		--ref-ld-chr-cts ~/CellTypes.ldct \									#address to ldct file
    		--w-ld-chr ~/weights/hg38/weights.									#address to weights for hapmap3
done
