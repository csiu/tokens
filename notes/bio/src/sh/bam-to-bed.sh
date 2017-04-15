## Reference: http://bedtools.readthedocs.org/en/latest/content/tools/bamtobed.html
PREFIX=$1

bedtools bamtobed -i ${PREFIX}.bam > ${PREFIX}.bed
