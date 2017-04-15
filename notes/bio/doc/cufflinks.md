## Cufflinks
> _Transcriptome assembly and differential expression analysis for RNA-Seq._

[**The Cufflinks RNA-Seq workflow**](http://cole-trapnell-lab.github.io/cufflinks/manual/)

<img src="http://cole-trapnell-lab.github.io/cufflinks/images/tuxedo_workflow.png" align="middle">

- [Cufflinks protocol paper by Trapnell et al 2012](http://www.nature.com/nprot/journal/v7/n3/full/nprot.2012.016.html)

----

`cufflinks` -- assembles transcriptomes from RNA-Seq data and quantifies their expression.

    cufflinks [options] <aligned_reads.(sam/bam)>
    
- [Options](http://cole-trapnell-lab.github.io/cufflinks/cufflinks/index.html) may include:
    - `-p <num_threads>`
    - `-G <GTF>` to quantitate against reference transcript annotations
    - `-o <output_dir>`
    - `-v` (or `-q`) for log-friendly verbose (or quiet) processing (no progress bar)
- The `<aligned_reads.(sam/bam)>` is the [`accepted_hits.bam` output file from TopHat](tophat.md)

