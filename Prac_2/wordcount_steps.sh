
Step 1: Set up Directories and Input Files
Create a new folder for the practical files:
[cloudera@quickstart ~]$ mkdir Prac_2

Navigate to the folder:
[cloudera@quickstart ~]$ cd Prac_2

Create the input text file (Processfile1.txt) to count words:
[cloudera@quickstart Prac_2]$ cat > Processfile1.txt

Then add the following content and press Ctrl + D to save:
Riyaz Ahamed
Riyaz Ahamed
Riyaz Ahamed
Cloudera
cloudera
cloudera
Big Data
Big Data
Big Data
Cloudera
Riyaz Ahamed
Riyaz Ahamed

Verify the contents of the file:
[cloudera@quickstart Prac_2]$ cat Processfile1.txt


Step 2: Upload the Input File to HDFS
Create an HDFS directory to store the file:
[cloudera@quickstart Prac_2]$ hdfs dfs -mkdir /Prac_2


Upload Processfile1.txt to the HDFS directory:
[cloudera@quickstart Prac_2]$ hdfs dfs -put Processfile1.txt /Prac_2


Verify the file upload in HDFS:
[cloudera@quickstart Prac_2]$ hdfs dfs -ls /Prac_2


Step 3: Run the WordCount Job
Execute the WordCount MapReduce job using the jar file:
[cloudera@quickstart ~]$ hadoop jar /home/cloudera/Prac_2/WordCount.jar wordcount/WordCount /Prac_2/Processfile1.txt /output_prac_2
hadoop jar <path_to_jar_file> <package_name/Class_name> <input_path_in_hdfs> <output_path_in_hdfs>


Step 4: Verify the Output in HDFS
Check if the output directory is created:
[cloudera@quickstart ~]$ hdfs dfs -ls /output_prac_2

Read the output file to see the word counts:
[cloudera@quickstart ~]$ hdfs dfs -cat /output_prac_2/part-r-00000

Expected output:
Ahamed     5
Big        3
Cloudera   2
Data       3
Riyaz      5
cloudera   2


Step 5: Clean Up (Optional)
Remove the input and output directories from HDFS if needed:
[cloudera@quickstart ~]$ hdfs dfs -rm -r /Prac_2 /output_prac_2

Command to delete output directory in HDFS:
hdfs dfs -rm -r /output_prac_2

******************************************************************************************************
before creation ad jars or can do after step 1 ie step 2


Step 1: Set Up the Directory Structure
If your project is in Eclipse or another IDE, the structure should be something like:
WordCount/               # Project root
 ├── src/                # Source folder
 │   └── wordcount/      # Package folder
 │       └── WordCount.java  # Java source file
 └── bin/                # Compiled classes output (if specified in Eclipse)

step 2: wordcount right click
build path
configure build path --add external jars
file systm - user - lib- hadoop -- select all
again add external jars 
file sytem -user-lib-hadoop-client --select all jars

***************** WordCount.java ***********************************

import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class WordCount {

  public static class TokenizerMapper
       extends Mapper<Object, Text, Text, IntWritable>{

    private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();

    public void map(Object key, Text value, Context context
                    ) throws IOException, InterruptedException {
      StringTokenizer itr = new StringTokenizer(value.toString());
      while (itr.hasMoreTokens()) {
        word.set(itr.nextToken());
        context.write(word, one);
      }
    }
  }

  public static class IntSumReducer
       extends Reducer<Text,IntWritable,Text,IntWritable> {
    private IntWritable result = new IntWritable();

    public void reduce(Text key, Iterable<IntWritable> values,
                       Context context
                       ) throws IOException, InterruptedException {
      int sum = 0;
      for (IntWritable val : values) {
        sum += val.get();
      }
      result.set(sum);
      context.write(key, result);
    }
  }

  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    Job job = Job.getInstance(conf, "word count");
    job.setJarByClass(WordCount.class);
    job.setMapperClass(TokenizerMapper.class);
    job.setCombinerClass(IntSumReducer.class);
    job.setReducerClass(IntSumReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}


right click on wordcount thn export
java - jar file

borwse the path and save it in pract2 as WordCount (save as name)



