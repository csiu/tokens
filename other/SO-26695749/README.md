**[STATUS: Resolved]**

----
# [Problem](http://stackoverflow.com/questions/26695749)
- There is 100000 lines in [example.dat](example.dat)
- If I set a count threshold of 594, I expect 517 counts to be returned
- The count of "0" should be 594, but MapReduce is not returning anything

```
[Sat Nov 01 21:06:35]$ grep -c '^0 \| 0 \| 0$' example.dat
594
```

# Solution
- Was using `import org.apache.hadoop.mapred.*;` - this package is deprecated
(& I found that it was producing strange behaviour)
- Use `org.apache.hadoop.mapreduce` instead
```
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
```
