# ATAC.Integrate
Pipeline for automatic integration of open chromatin regions (peaks) and GWAS data.

# Bulk ATAC-seq data

## Required files:
<ol>
  <li> Simple BED files containing open chromatin region base-pair locations
    <ol>
      <li> Format: CHRX -- Start -- End </li>
      <li> ***Important***: Ensure that each individual cell type is assigned a single .bed file containing peaks for the entire genome, and is named without any spaces. (i.e. CD14.positive.monocyte.bed) </li>
    </ol>
  </li>
  <li> PLINK .bim files </li>
  <li> Hapmap3 SNPs file </li>
  <li> Baseline LD file for reference genome </li>
  <li> No HLA weights for hapmap 3 </li>
  <li> GWAS .sumstats file </li>
</ol>


      
    

## Step 1 --> makeAnnotationsStep1.sh
Inputs: 
