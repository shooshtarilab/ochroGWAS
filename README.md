# EPI.Enrich
This repository contains the pipeline for integration of GWAS and open chromatin regions (peaks) data using LDSC. The following procedures require high performance computing which has been done in this project using Compute Canada. All bash scripts are therefore customed to run on compute canada clusters. The first 4 lines of any bash script contains information for the cluster to allocate optimised resources to the job, while the next three lines Comments have been made to get a comprehensive understanding of various steps involved. 

# Bulk data

## Required files:
<ol>
  <li> Simple BED files containing open chromatin region base-pair locations
    <ol>
      <li> Format: CHRX -- Start -- End </li>
      <li> IMPORTANT: Ensure that each individual cell type is assigned a single .bed file containing peaks for the entire genome, and is named without any spaces. (i.e. CD14.positive.monocyte.bed) </li>
    </ol>
  </li>
  <li> PLINK .bim files </li>
  <li> Hapmap3 SNPs file </li>
  <li> Baseline LD file for reference genome </li>
  <li> No HLA weights for hapmap 3 </li>
  <li> GWAS .sumstats file </li>
</ol>


      
    

## Step 1 --> makeAnnotationsStep1.sh
### Inputs: 
--bed-file \<bedfiles directory\>, --bimfile \<PLINK directory\>

### Outputs:
--annot-file \<output directory\>

### Function:
- Creates a binary annotation file representing SNP locations

## Step 2 --> ldsc.py
### Inputs:
--bfile \<PLINK directory\>, --annot \<annotation directory\>, --print-snps \<hapmap3 SNPs directory\>

### Outputs:
--out \<output directory\>

### Function:
- Runs LDSC regression to generate ld files for each of the listed cell types
