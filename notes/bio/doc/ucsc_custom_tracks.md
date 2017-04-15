# UCSC Custom Tracks 
## Histogram
This can be done using [BedGraph format](http://genome.ucsc.edu/goldenpath/help/bedgraph.html):

```
browser position chr1:9330-11329
track type=bedGraph name=exampleHistogram color=134,0,136, visibility=full alwaysZero=on maxHeightPixels=50,15,1
chr1    9800    9999    2
chr1    10000   10199   3
chr1    10200   10399   3
chr1    10400   10599   3
```

- [Converting Bam To BedGraph For Viewing On Ucsc?](https://www.biostars.org/p/64495/)

## Layered track
The proper terminology is "multiWig" track format (Raney et al 2015^[[Track data hubs enable visualization of user-defined genome-wide annotations on the UCSC Genome Browser](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3967101/)]). Other key words include:

> bigDataUrls, bigWigs, track hub, **multiwig**, `trackDb.txt`, `hub.txt`

To create the multiWig, you will need 3 files:

1. [`hub.txt`](http://genome.ucsc.edu/goldenPath/help/examples/hubExamples/hubGroupings/hub.txt)
2. [`genomes.txt`](http://genome.ucsc.edu/goldenPath/help/examples/hubExamples/hubGroupings/genomes.txt)
3. [`trackDb.txt`](http://genome.ucsc.edu/goldenPath/help/examples/hubExamples/hubGroupings/hg19/trackDb.txt) ... Note: there are 3 types of track groupings
    - "multiWig" track -> think overlay histograms
    ```
track multiWigUniqueTrackName 
type bigWig
container multiWig
aggregate transparentOverlay
showSubtrackColorOnUi on
maxHeightPixels 500:100:8
...
    track uniqueNameWithoutSpaces 
    type bigWig
    parent multiWigUniqueTrackName 
    color 255,0,0
    ```
    - "composite" track -> think group and display together (but not overlay) ... internal subgrouping
    ```
track uniqueCompositeTrackName 
compositeTrack on
...
    track uniqueNameWithoutSpaces 
    parent uniqueCompositeTrackName on 
    ...
    track newUniqueNameWithoutSpaces 
    parent uniqueCompositeTrackName off 
    ```
    - "super-tracks" -> for cases where there is several data types/no specific configuration
    ```
track uniqueSuperTrackName 
superTrack on show
...
    track uniqueNameWithoutSpaces 
    parent uniqueSuperTrackName 
    ...
    track newUniqueNameWithoutSpaces 
    parent uniqueSuperTrackName 
    ...
    track uniqueCompositeTrackNameInSuperTrack 
    compositeTrack on
    parent uniqueSuperTrackName 
    ...
        track uniqueNameWithoutSpaces 
        parent uniqueCompositeTrackNameInSuperTrack on 
        ...
        track newUniqueNameWithoutSpaces 
        parent uniqueCompositeTrackNameInSuperTrack off 
    ```

**Upload custom track**

`http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&hubUrl=<hub.txt>`

Example: http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&hubUrl=http://www.bcgsc.ca/downloads/csiu/ucsc-custom-tracks/histone_hub/hub.txt

**Resources**

- Minimal tutorials form assorted blog posts:
    - [UCSC Genome Browser custom overlap tracks](http://davetang.org/muse/2012/03/15/ucsc-genome-browser-custom-overlap-tracks/)
    - [Minimal UCSC Track Hubs](http://blog.mcbryan.co.uk/2013/04/minimal-ucsc-track-hubs.html)
    - [ctokheim/UCSCTrackHub.md](https://gist.github.com/ctokheim/5209723) <- I like this one
- Official UCSC documentations:
    - [Quick Start Guide to Organizing Track Hubs into Groupings](https://genome.ucsc.edu/goldenPath/help/hubQuickStartGroups.html)
    - [Using UCSC Genome Browser Track Hubs](http://genome.ucsc.edu/goldenPath/help/hgTrackHubHelp.html)
    - [Aggregate or Overlay Tracks: multiWig](http://genome.ucsc.edu/goldenPath/help/trackDb/trackDbHub.html#aggregate)
- Related forum questions:
    - [layered H3K27me3 data](https://groups.google.com/a/soe.ucsc.edu/forum/#!topic/genome/vjCE-t0LedM) 
    - [Tutorial: Overlay Multiple Tracks in Ucsc Browser](https://www.biostars.org/p/66745/)
- Example: Layered H3K27Ac Track from ENCODE
    - [Track Settings](http://ucscbrowser.genap.ca/cgi-bin/hgTrackUi?db=hg19&g=wgEncodeRegMarkH3k27ac)
    - [Track download](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeRegMarkH3k27ac/) (in bigwig format)
- Tools
    - http://homer.salk.edu/homer/ngs/ucsc.html -- "multi-wig hub"

![](http://homer.salk.edu/homer/ngs/ucsc.hubExample.png)

- Tip
    - You can also stack the tracks: [New UCSC “stacked” wiggle track view](http://blog.openhelix.eu/?p=19029)

## Resources
- [UCSC software utilities](http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/)
- [UCSC Displaying Your Own Annotations in the Genome Browser](https://genome.ucsc.edu/goldenpath/help/customTrack.html)
    
- [UCSC Data File formats](https://genome.ucsc.edu/FAQ/FAQformat.html)
    - **BED format** - if data is BED-like but very large (> 50Mb), use bigBed. **bigBed format** is an indexed binary format created from `bedToBigBed`
    - **BED detail format** - is an extension of BED format to enhance the track details pages
    - **bedGraph format** - allows display of continuous-valued data (e.g. probability scores & transcriptome data) in track format. Is similar to WIG, but data is exposed; for large data set, use bigWig
    - **WIG format** - allows display of continuous-valued data in track format. **bigWig format**  is an indexed binary format for display of dense, continuous data. They can be created from WIG using `wigToBigWig` or from bedGraph using `bedGraphToBigWig`
    - **PSL format** - represents alignments
    - **GFF format** - General Feature Format
    - **GTF format** - Gene Transfer Format is a refinement to GFF
    - **HAL format** - is a graph-based structure
    - **MAF format** - multiple alignment format 
    - **BAM format** - compressed version of SAM. [BAM custom tracks](https://genome.ucsc.edu/goldenPath/help/bam.html).
    - **Microarray format**
    - **GenePrd table format** is for gene prediction tracks / **bigGenePred table format**
    - **Personal Genome SNP format** is for displaying SNPs from personal genomes
    - **VCF format** is for variation data
    - ENCODE specific formats include: **RNA elements**, **narrowPeak**, **broadPeak**, **gappedPeak**, **tagAlign**, **pairedTagAlign**, **peptideMapping**
    - Download formats include: **Fasta**, **FastQ**, **.2bit**, and **.nib** formats
