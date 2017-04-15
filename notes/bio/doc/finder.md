## FindER

> to Find Enriched Regions ([FindER](http://www.epigenomes.ca/finder.html) v1.0.0) in ChIP-Seq datasets

![](http://www.epigenomes.ca/images/FindER.1.0.0b.overview.png)


### Usage
```
 java -jar -Xmx12G FindER.1.0.0b.jar -signalBam ${MARK_BAM} -inputBam ${CONTROL_BAM} -out ${OUTDIR}
```

- Outputs 1 file:
    - bed file containing coordinates of enriched regions (chr, start, end) and -log10(p-value)
