# Resource files
## Genome
- hg19/GRCh37
    - [`GRCh37-lite.fa.gz`](ftp://ftp.ncbi.nih.gov/genbank/genomes/Eukaryotes/vertebrates_mammals/Homo_sapiens/GRCh37/special_requests/) genome assembly
- hg18/GRCh36

[UCSC](http://hgdownload.cse.ucsc.edu/downloads.html#human) is an excellent resource. Specific resources include:

- http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/. You can also download the data from the [UCSC Table Browser](http://genome.ucsc.edu/cgi-bin/hgTables).
    - `cytoBand.txt.gz` for positions of the cytobands
    - `gap.txt.gz` for positions of the centromere, telomere
        - output columns + [description](http://genome.ucsc.edu/goldenpath/gbdDescriptionsOld.html#GapInfo)
        ```
#bin  chrom chromStart  chromEnd  ix  n size  type  bridge
        ```

    - `hg19.chrom.sizes` for chomosome sizes

Other resources:

- [Ensembl](http://feb2014.archive.ensembl.org/info/data/ftp/index.html) gene sets
- [FANTOM5 data](http://fantom.gsc.riken.jp/data/) including hg19 cage peaks, [enhancers](http://fantom.gsc.riken.jp/5/datafiles/latest/extra/Enhancers/)
- [FANTOM5 derived/PrESSTo](http://enhancer.binf.ku.dk/presets/) for tissue specific enhancers/promoters

How to obtain:

- [hg19 promoter regions](http://seqanswers.com/forums/showthread.php?t=11296)

## Tools
- [ENCODE software tools](https://genome.ucsc.edu/ENCODE/softwareTools.html)
- [ROADMAP tools](http://www.roadmapepigenomics.org/tools)
- [UCSC other utilities for linux.x86_64](http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/)
- [OMICS tools](http://omictools.com/)
- [SeqAnswers Software/list](http://seqanswers.com/wiki/Software/list)
