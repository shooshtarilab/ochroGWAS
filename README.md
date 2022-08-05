# EPI.Enrich
This repository contains the pipeline for integration of GWAS and open chromatin regions (peaks) data using LDSC. The following procedures require high performance computing which has been done in this project using Compute Canada. All bash scripts are therefore customed to run on compute canada clusters. The first 4 lines of any bash script contains information for the cluster to allocate optimised resources to the job, while the next three lines Comments have been made to get a comprehensive understanding of various steps involved. hg38 has been used for all files. For more information regarding the working of the python scripts, please refer to https://github.com/bulik/ldsc/wiki

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


## Step 1 &#8594; Step1_Annotations.sh

Uses make_annot.py to make annotation files for all cell types (.bed files).

### Inputs: 
--bed-file \<bedfiles directory\> &#8594; Containing peaks of cell types,
--bimfile \<PLINK directory\>     &#8594; Contains information about the SNPs in each chromosome

### Outputs:
--annot-file \<output directory\> &#8594; Directory to geenrate annotation files

### Function:
- Creates a binary annotation file representing SNP locations within open chromatin region for each chromosome of every cell type. SNPs are represented by 1s if present in open chromatin region, else zero. 

## Step 2 &#8594; Step2_LDSC.sh

Uses ldsc.py to calculate ldscores from annotation files. Inputs required are -bfiles (.bed,.bim,.fam files of PLINK)

### Inputs:
--bfile \<PLINK directory\>               &#8594; PLINK directory
--annot \<annotation directory\>          &#8594; Annotation directory
--print-snps \<hapmap3 SNPs directory\>   &#8594; Hapmap3 SNP directory

### Outputs:
--out \<output directory\>

### Function:
- Runs LDSC regression to generate LD files for each of the listed cell types. 


## Step 3 &#8594; Step3_GWAS.sh

Integrates the GWAS sumstats data with LDSC from previous step. One important requirement of this step is the generation of ".ldct" file. This file contains the information about the cell type and the location of their LD score files. It can be created manually as well. The format is in the following way: 

>CellType1      ~/ldscores/CellType1. \n
>CellType2      ~/ldscores/CellType2.

and so on for all cell types.

### Step 3 :
--h2-cts \<SUMSTATS file\>          &#8594; SUMSTATs file of the phenotype to be analysed
--ref-ld-chr \<Baseline LD\>        &#8594; Baseline LD files for reference genome
--ref-ld-chr-cts \<ldct file\>      &#8594; LDCT file for reference (mentioned above)
--w-ld-chr  \<No HLA weights\>      &#8594; No HLA weights for Hapmap3 directory

### Outputs:
--out \<Output directory\>          &#8594; Directory to output files

### Function:
- Integrates GWAS with previously generated files and outputs p-values. 

## Further Steps

The next step is to adjust p-values using Benjamini-Hoschberg correction with a threshold of 0.05. Once that has been done, heatmaps can be generated and visualisations can be done. 
