**[Status: Resolved]**

# Goal:
Word count with filter of data [simple.dat](simple.dat)

## RE: [TestCase.java](TestCase.java)
Word count code originally modified from:
http://hadoop.apache.org/docs/r1.2.1/mapred_tutorial.html#Source+Code

### Expected output
```
529	   3
825	   3
39	   2
496	   2
674	   2
704	   2
834	   2
883	   2
```

### Actual output
```
529    3
825    3
39     2
496    2
704    2
834    2
```

Note: am missing words: "674" and "883"

----

## RE: [TestCaseV2.java](TestCaseV2.java)

Upon advice of [irrelephant](https://stackoverflow.com/users/485971/irrelephant),
used `hadoop.mapreduce` package instead of `hadoop.mapred` package.

Word count code originally modified from:
http://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html#Source_Code

This works! (see [TestCaseV2.java](TestCaseV2.java))
