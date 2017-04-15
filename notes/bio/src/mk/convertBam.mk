MK_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(MK_DIR)/pathSoftware.mk

.PHONY: clean

all:


%.bed: %.bam
        $(BEDTOOLS) bamtobed -i $< > $@

%.bai: %.bam
        $(SAMTOOLS) index $<

%.end1.fq %.end2.fq: %.bam
        $(SAMTOOLS) sort -n $< $*.qsort
        $(BEDTOOLS) bamtofastq -i $*.qsort.bam -fq $*.end1.fq -fq2 $*.end2.fq
