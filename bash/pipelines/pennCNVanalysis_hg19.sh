#!/bin/bash

## PennCNV-Affy Protocol for CNV detection in Affymetrix SNP arrays
## INSTRUCTIONS: http://www.openbioinformatics.org/penncnv/penncnv_tutorial_affy_gw6.html

## USAGE:
##   this-script.sh listfile
## ABOUT:
##   The 'listfile' contains a list of CEL file names, with one name per line, and with the first line being “cel_files”
listfile=$1


## Dependencies:
## 1. PennCNV software from http://www.openbioinformatics.org/penncnv/download/penncnv.latest.tar.gz and uncompress the file
PENNCNV= #[path/to/penncnv]
## 2. PennCNV-Affy programs and library files from http://www.openbioinformatics.org/penncnv/download/gw6.tar.gz and uncompress the file
GW6= #[path/to/gw6]
## 3. Affymetrix Power Tools (APT) software package from http://www.affymetrix.com/support/developer/powertools/index.affx ... need to configure & make file
APT= #[path/to/apt-1.14.4.1-src/sdk/output/*/bin/] 
## 4. library files for the genome-wide 6.0 array from http://www.affymetrix.com/Auth/support/downloads/library_files/genomewidesnp6_libraryfile.zip
GW6_LIB_FILES= #[path/to/CD_GenomeWideSNP_6_rev3]


#Step 1: Generate genotyping calls from CEL files
echo "Running Step 1 - genotypeing";
${APT}/apt-probeset-genotype -c ${GW6_LIB_FILES}/Full/GenomeWideSNP_6/LibFiles/GenomeWideSNP_6.cdf -a birdseed --read-models-birdseed ${GW6_LIB_FILES}/Full/GenomeWideSNP_6/LibFiles/GenomeWideSNP_6.birdseed.models --special-snps ${GW6_LIB_FILES}/Full/GenomeWideSNP_6/LibFiles/GenomeWideSNP_6.specialSNPs --out-dir apt --cel-files ${listfile}

#Step 2: Allele-specific signal extraction from CEL files
echo "Running Step 2 - probeset summarization";
${APT}/apt-probeset-summarize --cdf-file ${GW6_LIB_FILES}/Full/GenomeWideSNP_6/LibFiles/GenomeWideSNP_6.cdf --analysis quant-norm.sketch=50000,pm-only,med-polish,expr.genotype=true --target-sketch ${GW6}/lib/hapmap.quant-norm.normalization-target.txt --out-dir apt --cel-files ${listfile}

#Step 3: Log R Ratio (LRR) and B Allele Frequency (BAF) calculation
echo "Running Step 3 - B-allele and log ratios";
${GW6}/bin/normalize_affy_geno_cluster.pl ${GW6}/lib/hapmap.genocluster $PWD/apt/quant-norm.pm-only.med-polish.expr.summary.txt -locfile ${GW6}/lib/affygw6.hg19.pfb -out gw6.lrr_baf.txt

#Step 4: Split the signal file into individual files for CNV calling by PennCNV
echo "Split files by sample";
${PENNCNV}/kcolumn.pl gw6.lrr_baf.txt split 2 -tab -head 3 -name --beforestring .CEL -out gw6
