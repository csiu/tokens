BIN ?=

BEDTOOLS ?= $(BIN)/bedtools
BISMARK  ?= $(BIN)/bismark
BISMARKGENOMEPREPARATION ?= $(BIN)/bismark_genome_preparation
BOWTIE        ?= $(BIN)/bowtie
BOWTIE2       ?= $(BIN)/bowtie2
BOWTIEBUILD   ?= $(BIN)/bowtie-build
BOWTIEINSPECT ?= $(BIN)/bowtie-inspect
CUFFLINKS ?= $(BIN)/cufflinks
SAMTOOLS  ?= $(BIN)/samtools
TOPHAT    ?= $(BIN)/tophat

BEDGRAPHTOBIGWIG ?= $(BIN)/bedGraphToBigWig
BIGWIGTOBEDGRAPH ?= $(BIN)/bigWigToBedGraph

## Jars
CHROMHMM  ?= $(BIN)/ChromHMM.jar
FINDER    ?= $(BIN)/FindER.1.0.0b.jar

## General
GIT      ?= $(BIN)/git
PYTHON27 ?= $(BIN)/python2.7

## Converting between bibliography formats (via bibutils)
BIB2XML      ?= $(BIN)/bib2xml
BIBLATEX2XML ?= $(BIN)/biblatex2xml
COPAC2XML    ?= $(BIN)/copac2xml
EBI2XML      ?= $(BIN)/ebi2xml
END2XML      ?= $(BIN)/end2xml
ENDX2XML     ?= $(BIN)/endx2xml
ISI2XML      ?= $(BIN)/isi2xml
MED2XML      ?= $(BIN)/med2xml
MODSCLEAN    ?= $(BIN)/modsclean
RIS2XML      ?= $(BIN)/ris2xml
WORDBIB2XML  ?= $(BIN)/wordbib2xml
XML2ADS      ?= $(BIN)/xml2ads
XML2BIB      ?= $(BIN)/xml2bib
XML2END      ?= $(BIN)/xml2end
XML2ISI      ?= $(BIN)/xml2isi
XML2RIS      ?= $(BIN)/xml2ris
XML2WORDBIB  ?= $(BIN)/xml2wordbib
