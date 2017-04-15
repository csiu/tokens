## Reference: http://bedtools.readthedocs.org/en/latest/content/tools/bamtofastq.html
BAMFILE=`readlink -f $1`

ALN=${BAMFILE/%.bam/}

samtools sort -n ${ALN}.bam ${ALN}.qsort
bedtools bamtofastq -i ${ALN}.qsort.bam -fq ${ALN}.end1.fq -fq2 ${ALN}.end2.fq
