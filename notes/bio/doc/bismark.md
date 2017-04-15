## Bismark
> [Bismark](http://www.bioinformatics.babraham.ac.uk/projects/bismark/)  A bisulfite read mapper and methylation caller 

- [Bismark paper by Krueger and Andrews 2011](http://www.ncbi.nlm.nih.gov/pubmed/21493656)
- [Bismark user guide](http://www.bioinformatics.babraham.ac.uk/projects/bismark/Bismark_User_Guide.pdf)

- [Review of primary data analysis in BS-Seq by Krueger et al 2012](http://www.ncbi.nlm.nih.gov/pubmed/22290186)

### Requirements
- Bowtie or Bowtie2
- Samtools
- reference genome (`.fa` or `.fasta`)

### Step 0: `bismark_genome_preparation`
- Usage: `bismark_genome_preparation [options] <path_to_genome_folder>`

```
/bismark/bismark_genome_preparation --path_to_bowtie /usr/local/bowtie/ --verbose /data/genomes/homo_sapiens/GRCh37/
```

- creates 2 individual folders within this directory (one for C->T converted genome and the other for G->A converted genome) ... these genomes will also be indexed by `bowtie-build`/`bowtie2-build`


### Step 2: Running bismark
- Usage: `bismark [options] <genome_folder> {-1 <mates1> -2 <mates2> |
<singles>}`
- Example

```
bismark -n 1 -l 50 /data/genomes/homo_sapiens/GRCh37/ test_dataset.fastq
```

- outputs 2 files:
    - `*.fastq_bismark.sam` - containing all alignments plus methylation call strings
    - `*.fastq_bismark_SE_report.txt` - containing alignments and methylation summary
    
- note: options include 
```
Alignment:

-n/--seedmms <int>       The maximum number of mismatches permitted in the "seed", i.e. the first L base pairs
                         of the read (where L is set with -l/--seedlen). This may be 0, 1, 2 or 3 and the 
                         default is 1. This option is only available for Bowtie 1 (for Bowtie 2 see -N).

-l/--seedlen             The "seed length"; i.e., the number of bases of the high quality end of the read to
                         which the -n ceiling applies. The default is 28. Bowtie (and thus Bismark) is faster for
                         larger values of -l. This option is only available for Bowtie 1 (for Bowtie 2 see -L).
```

### Step 3: `bismark_methylation_extractor`
- Usage: `bismark_methylation_extractor [options] <filenames>`
- Example to extract context-dependent (CpG/CHG/CHH; where H = not nucleotide G)

```
bismark_methylation_extractor -s --comprehensive test_dataset.fastq_bismark.sam
```

- outputs 3 files:
    - `CpG_context_*.fastq_bismark.txt`
    - `CHG_context_*.fastq_bismark.txt`
    - `CHH_context_*.fastq_bismark.txt`

