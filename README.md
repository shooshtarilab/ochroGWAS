# ochroGWAS
This page contains data related to the following paper:
### Title:
Single-cell chromatin accessibility data combined with GWAS improves detection of relevant cell types in 59 complex phenotypes
### Authors:
Akash Chandra Das (akashchandra@iitg.ac.in), Aidin Foroutan (aidin.foroutan@uwo.ca), Brian Qian (bqian7@uwo.ca), Nader Hosseini Naghavi (nhosse2@uwo.ca), Kayvan Shabani (kshaban2@uwo.ca), Parisa Shooshtari (pshoosh@uwo.ca)

##
This repository contains the pipeline for integration of genome-wide association studies (GWAS) data and open chromatin regions (peaks) data using linkage disequilibrium score (LDSC) regression. The following procedures require high-performance computing which has been done in this project using Compute Canada. All bash scripts are therefore customed to run on compute canada clusters. The first 4 lines of any bash script contain information for the cluster to allocate optimised resources to the job, while the next three lines creates a virtual environment for the job to run on with the versions of python and bedtools required by ldsc. Comments have been made to get a comprehensive understanding of the various steps involved. hg38 has been used for all files. For more information regarding the working of the python scripts of ldsc, please refer to https://github.com/bulik/ldsc/wiki. 

For all the following steps, we have used bulk-sequencing dataset (https://dhs.ccm.sickkids.ca/) and single-cell ATAC sequencing dataset (https://www.cell.com/cell/fulltext/S0092-8674(21)01279-4) and integrated them with GWAS (https://www.nature.com/articles/s41588-021-00931-x). The relevant peak files and ".sumstats" files required for the following steps need to be downloaded from above mentioned resources.


## 1. Processing
### Required files:
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


### Step 1 &#8594; Step1_Annotations.sh

Uses make_annot.py to make annotation files for all cell types (.bed files).

#### Inputs: 
--bed-file \<bedfiles directory\> &#8594; Peak data directory<br />
--bimfile \<PLINK directory\>     &#8594; PLINK directory <br />

#### Outputs:
--annot-file \<output directory\> &#8594; Output of annotations file directory

#### Function:
- Creates a binary annotation file representing SNP locations within the open chromatin regions for each chromosome of every cell type. SNPs are represented by 1s if present in the open chromatin regions, else zero. 

### Step 2 &#8594; Step2_LDSC.sh

Uses ldsc.py to calculate ldscores from annotation files. Inputs required are -bfiles (.bed,.bim,.fam files of PLINK), annotation files from previous step and Hapmap3 SNPs file. 

#### Inputs:
--bfile \<PLINK directory\>               &#8594; PLINK directory<br />
--annot \<annotation directory\>          &#8594; Annotation directory from previous step <br />
--print-snps \<hapmap3 SNPs directory\>   &#8594; Hapmap3 SNP directory<br />

#### Outputs:
--out \<output directory\>                 &#8594; Output directory to generate LDSC scores

#### Function:
- Runs LDSC regression to generate LD score files for each of the listed cell types. 


### Step 3 &#8594; Step3_GWAS.sh
##### (Prerequisite)
One important pre-requisite to this step is the generation of ".ldct" file. This file contains information about the cell type and the location of their LD score files. *Step3(pre)_CreateLDCT.py* can be used for this purpose. It can be created manually as well. The format is in the following way: 

>CellType1      ~/ldscores/CellType1.<br />
>CellType2      ~/ldscores/CellType2.<br />

and so on for all cell types.

##### GWAS Integration
Integrates the GWAS sumstats data with LDSC from previous step. Below are the inputs and outputs for Step3_GWAS.sh

#### Inputs:
--h2-cts \<SUMSTATS file\>          &#8594; SUMSTATs file of the phenotype to be analysed<br />
--ref-ld-chr \<Baseline LD\>        &#8594; Baseline LD files for reference genome<br />
--ref-ld-chr-cts \<ldct file\>      &#8594; LDCT file for reference (mentioned above)<br />
--w-ld-chr  \<No HLA weights\>      &#8594; No HLA weights for Hapmap3 directory<br />

#### Outputs:
--out \<Output directory\>          &#8594; Directory to output files for generated p-values

#### Function:
- Integrates GWAS with previously generated LD score files and outputs p-values. 

### Further Steps

The final outputs from the above steps are text files containing p-values of association of all cell-types for each GWAS. Each file has the name of the GWAS used for integration and contains all the cell types in increasing order of p-values. These p-values should be adjusted using Benjamini-Hoschberg correction with an FDR threshold of 0.05, and similar step should be done for all phenotypes. Once that has been done, the results can be concatenated, heatmaps can be generated and visualisations can be done.

## 2. Visualisation

### Scripts

The R scripts in this folder can be run to visualise the analysis and generate figures mentioned in the paper. The order has been maintaned, and the input file required for these scripts are present in the **Input_Data** folder. The input files and scripts have been named according to the figure they are used for (Figure3_immune_cells_adult.csv and Figure3_immune_cells_fetal.csv is used by Figure3_immune_cells_script.R to generate Figure1.png). Similarly for the rest. The output that could be generated (the main and supplementary figures of the paper) are in the **Output_Figures** folder.
