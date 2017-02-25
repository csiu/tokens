package org.myorg;

import java.io.IOException;
import java.util.*;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapred.*;
import org.apache.hadoop.util.*;

public class TestCase {
    public static class Map1 extends MapReduceBase implements Mapper<LongWritable, Text, Text, IntWritable> {
      private final static IntWritable one = new IntWritable(1);
      private Text word = new Text();

      public void map(LongWritable key, Text value, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
        String line = value.toString();
        StringTokenizer tokenizer = new StringTokenizer(line);
        while (tokenizer.hasMoreTokens()) {
          word.set(tokenizer.nextToken());
          output.collect(word, one);
        }
      }
    }

    public static class Reduce1 extends MapReduceBase implements Reducer<Text, IntWritable, Text, IntWritable> {
      public void reduce(Text key, Iterator<IntWritable> values, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
        int sum = 0;
        while (values.hasNext()) {
          sum += values.next().get();
        } 
        if (sum >= 2) { //FIXME: filter here?
          output.collect(key, new IntWritable(sum));
        }
      }
    }

    public static void main(String[] args) throws Exception {

      JobConf job1 = new JobConf(TestCase.class);
      job1.setJobName("TestCase");

      job1.setOutputKeyClass(Text.class);
      job1.setOutputValueClass(IntWritable.class);

      job1.setMapperClass(Map1.class);
      job1.setCombinerClass(Reduce1.class);
      job1.setReducerClass(Reduce1.class);

      job1.setInputFormat(TextInputFormat.class);
      job1.setOutputFormat(TextOutputFormat.class);

      FileInputFormat.setInputPaths(job1, new Path(args[0]));
      FileOutputFormat.setOutputPath(job1, new Path(args[1]));

      JobClient.runJob(job1);
    }
}
