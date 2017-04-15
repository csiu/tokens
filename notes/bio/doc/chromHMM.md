## chromHMM

> [ChromHMM](http://compbio.mit.edu/ChromHMM/) is software for learning and characterizing chromatin states.

- [Nature paper](http://www.nature.com/nmeth/journal/v9/n3/full/nmeth.1906.html)
- [ChromHMM User Manual](http://compbio.mit.edu/ChromHMM/ChromHMM_manual.pdf)
- [ChromHMM tutorial](https://www.encodeproject.org/documents/d0a10470-b049-4da1-9de2-01449ddfa6a5/@@download/attachment/ChromHMM_tutorial.pdf)
- [Learning Chromatin States from ChIP-seq data](https://www.encodeproject.org/documents/049704a4-5c58-4631-acf1-4ef152bdb3ef/@@download/attachment/Learning_Chromatin_States_from_ChIP-seq_data.pdf)

### Pre-reqs
- java

- file: `chromosomelengthfile`
- file: `cellmarkfiletable` to identify the metadata; Example:

    ```
cell1 mark1 cell1_mark1.bed cell1_control.bed
cell1 mark2 cell1_mark2.bed cell1_control.bed
cell2 mark1 cell2_mark1.bed cell2_control.bed
cell2 mark2 cell2_mark2.bed cell2_control.bed
    ```

### Step1: BinarizeBam

> `BinarizeBam` -- converts a set of bam files of aligned reads into binarized data files for model learning and optionally prints the intermediate signal files

    BinarizeBamOptions="-b 200"

    java -mx3000M -jar ChromHMM.jar BinarizeBam $BinarizeBamOptions $chromosomelengthfile $inputbamdir $cellmarkfiletable $outputbinarydir

- `-b binsize` is an optional to denote resolution of model learning and segmentation (default = 200bp)
- if you have bed files, you can use `BinarizeBed`
- use `-peaks` if the bedfile contain peaks

### Step2: LearnModel

> `LearnModel` -- takes a set of binarized data files, learns chromatin state models, and by default produces a segmentation, generates browser output with default settings, and
calls OverlapEnrichment and NeighborhoodEnrichments with default settings for the specified genome assembly. A webpage is a created with links to all the files and images created.

    LearnModelOptions=""
    inputdir=$outputbinarydir
    numstates=17
    assembly=hg19

    java -mx1200M -jar ChromHMM.jar LearnModel $LearnModelOptions $inputdir $outputdir $numstates $assembly

- `numstates` depends on the number/which histone marks are present in your data
- optional args include `-p maxprocessors`
- **Tips:**
    - unless you know the sample is male, remove chr Y
    - to leverage info across samples during learning, keep the binarized data under a single input directory (`$inputdir`)
- LearnModel is essentially running: 
    - `MakeSegmentation`
    - `MakeBrowserFiles`
    - `OverlapEnrichment` + `-t "Fold Enrichment <sample-id>_<n-states>"` to denote figure title
    - `NeighborhoodEnrichment` + `-t "Fold Enrichment <sample-id>_<n-states> <id-of-anchor-file>"` to denote figure title

----

## Calling chromatin states from peak calls

1. start with chip-seq peaks in BED format
2. binarize data with `BinarizeBed -peaks`
3. run `LearnModel` to determine chromatin states

----

## Identifying chromatin states

- the identity of the states is determined by the user
    - [15 & 18 chromatin states from Roadmap](https://sites.google.com/site/anshulkundaje/projects/epigenomeroadmap#TOC-Core-Integrative-chromatin-state-maps-127-Epigenomes-); [15 states (from 5 marks) & 18 states (from 6 marks)](http://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html)
    - [Biesinger et al. 2013 used 18 states; Figure 4](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3622631/)
    - [Quang et al. 2015 used 9 states; Figure 1](http://www.epigeneticsandchromatin.com/content/8/1/23)
    - [Ernst & Kellis (2010) used 38 histone marks to find 51 states in human lymphocytes](http://www.nature.com/nmeth/journal/v8/n9/full/nmeth.1673.html#ref9)
    - [Julienne et al. 2013 used 13 epigenetic marks partitioned into 4 states; Figure 4 & 5](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3794905/)

- the identity of the states should be realistic with respect to genetic coverage. Examples of percent coverage of chromatin states:
    - [Roadmap Epigenomics Consortium et al. 2015](http://www.nature.com/nature/journal/v518/n7539/fig_tab/nature14248_F4.html)
    - [Yen & Kellis 2015](http://www.nature.com/ncomms/2015/150818/ncomms8973/fig_tab/ncomms8973_F1.html)
    - [Table 1 of Julienne et al. 2013](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3794905/)

### A closer look at [Roadmap](http://egg2.wustl.edu/roadmap/web_portal/chr_state_learning.html)

> **State labels, interpretation and mnemonics**
>
>  For any set of genomic coordinates representing a genomic feature and a given state, the fold enrichment of overlap is calculated as the ratio of the joint probability of a region belonging to the state and the feature” vs. “the product of independent marginal probability of observing the state in the genome” times “the probability of of observing the feature”, namely the ratio between the (#bases in state AND overlap feature)/(#bases in genome) and the [(#bases overlap feature)/(#bases in genome) X (#bases in state)/(#bases in genome)]. The neighborhood enrichment is computed for genomic bins around a set of single base pair anchor locations in the genome e.g. transcription start sites.
>
> For the **overlap enrichment** plots in the figures, the enrichments for each genomic feature (column) across all states is normalized by subtracting the minimum value from the column and then dividing by the max of the column. So the values always range from 0 (white) to 1 (dark blue) i.e. its a column wise relative scale. For the **neighborhood positional enrichment** plots, the normalization is done across all columns i.e. the minimum value over the entire matrix is subtracted from each value and divided by the maximum over the entire matrix.

![](http://egg2.wustl.edu/roadmap/figures/mainFigs/Figure_4.jpg)
![](http://www.nature.com/nature/journal/v518/n7539/images/nature14248-sf2.jpg)

- Annotation files for overlap enrichments: http://egg2.wustl.edu/roadmap/src/chromHMM/bin/COORDS/hg19/
    - Note: Look in `geneAnno/` and `expr/`
- Annotation files for neighborhood enrichments: http://egg2.wustl.edu/roadmap/src/chromHMM/bin/ANCHORFILES/hg19/

----

## Reordering (and coloring the results to be more Roadmap like)

```
$(JAVA) $(JAVA_OPT) -jar $(CHROMHMM) Reorder $(inputmodel) $(outputdir)
$(JAVA) $(JAVA_OPT) -jar $(CHROMHMM) MakeSegmentation $(modelfile) $(inputdir) $(outputdir)
$(JAVA) $(JAVA_OPT) -jar $(CHROMHMM) MakeBrowserFiles $(segmentfile) $(segmentationname) $(outputfileprefix)
$(JAVA) $(JAVA_OPT) -jar $(CHROMHMM) OverlapEnrichment $(inputsegment) $(inputcoorddir) $(outfileprefix)
$(JAVA) $(JAVA_OPT) -jar $(CHROMHMM) NeighborhoodEnrichment $(inputsegment) $(anchorpositions) $(outfileprefix)
```
