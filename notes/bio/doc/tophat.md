## TopHat

> [What is TopHat?](https://ccb.jhu.edu/software/tophat/manual.shtml)
> 
> TopHat is a program that aligns RNA-Seq reads to a genome in order to identify exon-exon splice junctions. It is built on the ultrafast short read mapping program Bowtie.

### Pre-req: in your `PATH`
    - bowtie2 and bowtie2-align (or bowtie)
    - bowtie2-inspect (or bowtie-inspect)
    - bowtie2-build (or bowtie-build)
    - samtools
    - Python version 2.6 or higher

### 1. Prep your reference: install a Bowtie index

> [**The bowtie-build indexer**](http://bowtie-bio.sourceforge.net/manual.shtml#the-bowtie-build-indexer)
> 
> `bowtie-build` builds a Bowtie index from a set of DNA sequences. `bowtie-build` outputs a set of 6 files with suffixes `.1.ebwt, .2.ebwt, .3.ebwt, .4.ebwt, .rev.1.ebwt, and .rev.2.ebwt`. (If the total length of all the input sequences is greater than about 4 billion, then the index files will end in `ebwtl` instead of `ebwt`.) These files together constitute the index: they are all that is needed to align reads to that reference. The original sequence files are no longer used by Bowtie once the index is built.

    bowtie-build [options]* <reference_in> <ebwt_base>

- Some indexes (e.g. UCSC hg19) is provided on [bowtie2's website](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
- Bowtie 2 can be used for TopHat v2.0 or later

### 2. Prep your reads (to FASTQ format)
- TopHat accepts reads in FASTA or FASTQ (recommended) format

### 3. Running TopHat
    tophat </path/to/index-dir/index-prefix> <PE_reads_1.fq.gz> <PE_reads_2.fq.gz>

- [Usage](https://ccb.jhu.edu/software/tophat/manual.shtml#toph): `tophat [options]* <genome_index_base> <reads1_1[,...,readsN_1]> [reads1_2,...readsN_2]`
- [Output](https://ccb.jhu.edu/software/tophat/manual.shtml#output) files you likely want to look at
  1. `accepted_hits.bam` -- list of read alignments
  2. `junctions.bed` -- UCSC BED track of reported junctions; score is # alignments spanning the junction
  3. `insertions.bed and deletions.bed` -- UCSC BED tracks of reported insertions (chromLeft = last base before insert) and deletions (chromLeft = first base of delete)
  
----
## Reference
- [TopHat: Getting started](https://ccb.jhu.edu/software/tophat/tutorial.shtml)
