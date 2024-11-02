
first create a Matrix_Multiply_M.txt text file in prac_2 folder in cloudera local directory 
open Matrix_Multiply_M.txt text file and copy paste the following code 
M,0,0,1
M,0,1,2
M,1,0,3
M,1,1,4

then create another Matrix_Multiply_N.txt text file in prac_2 folder in cloudera local directory 
open Matrix_Multiply_N.txt text file and copy paste the following code 
N,0,0,5
N,0,1,6
N,1,0,7
N,1,1,8




open eclipse in cloudera and create a new java projecct named - MatrixMultiplication  
and package name - matrix_multiplication
 and class name - MatrixMultiplication

 Directory structure

MatrixMultiplication/          # Project root
 ├── src/                      # Source folder
 │   └── matrix_multiplication/ # Package folder
 │       └── MatrixMultiplication.java # Java source file
 └── bin/                      # Compiled classes output (optional, if specified in IDE)


open eclipse in cloudera and create a java project and make sure to add the follwoing dependcies 
Step 1:(add jar files from hadoop and client) Ensure Hadoop Libraries are Added to the Build Path
Add Hadoop Libraries to the Project:
In Eclipse, right-click your project (MatrixMultiplication).
Go to Build Path > Configure Build Path > Libraries > Add External JARs.
Locate and add the following Hadoop JARs from your Hadoop installation (typically found in /usr/lib/hadoop or $HADOOP_HOME):
hadoop-common.jar
hadoop-mapreduce-client-core.jar 02.0
hadoop-hdfs.jar
hadoop-yarn-common.jar
hadoop-mapreduce-client-common.jar

 ****************************************************terminal**********************

Create input files for hadoop
hdfs dfs -mkdir /matrix_multiplication_1
[cloudera@quickstart ~]$ cd Prac_2
hdfs dfs -put Matrix_Multiply_M.txt /matrix_multiplication_1/
hdfs dfs -put Matrix_Multiply_N.txt /matrix_multiplication_1/



Execute the MapReduce Job
Run the JAR file in Hadoop:
hadoop jar matrix_multiply.jar matrix_multiplication.MatrixMultiplication /matrix_multiplication_1 /matrix_multiplication_1/output_matrix_1

//Check and Troubleshoot
//Verify that there are no existing output directories before running the job to avoid conflicts. Delete any previous output:
//hdfs dfs -rm -r /matrix_multiplication_1/output_matrix_1

View the Output
After the job completes successfully, check the output:
hdfs dfs -ls /
hdfs dfs -ls /matrix_multiplication_1/output_matrix_1

Use the hdfs dfs -cat command to view the result matrix:
hdfs dfs -cat /matrix_multiplication_1/output_matrix_1/part-r-00000

0,0    19
0,1    22
1,0    43
1,1    50


********* MatrixMultiplication.java *********************** 

package matrix_multiplication;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class MatrixMultiplication {

	public static class MatrixMapper extends Mapper<Object, Text, Text, Text> {

	    private Text outputKey = new Text();
	    private Text outputValue = new Text();

	    public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
	        // Print each line for debugging
	        System.out.println("Processing line: " + value.toString());
	        String[] tokens = value.toString().split(",");
	        
	        // Check if the line has the expected number of tokens
	        if (tokens.length != 4) {
	            System.err.println("Skipping line due to incorrect format: " + value.toString());
	            return;
	        }

	        String matrixName = tokens[0];
	        int row = Integer.parseInt(tokens[1]);
	        int col = Integer.parseInt(tokens[2]);
	        int matrixValue = Integer.parseInt(tokens[3]);
	        
	        if (matrixName.equals("M")) {
	            for (int k = 0; k < 2; k++) { // Assuming 2 columns in N
	                outputKey = new Text(row + "," + k);
	                outputValue = new Text("M," + col + "," + matrixValue);
	                context.write(outputKey, outputValue);
	            }
	        } else if (matrixName.equals("N")) {
	            for (int i = 0; i < 2; i++) { // Assuming 2 rows in M
	                outputKey = new Text(i + "," + col);
	                outputValue = new Text("N," + row + "," + matrixValue);
	                context.write(outputKey, outputValue);
	            }
	        }
	    }
	}
	                
	
    public static class MatrixReducer extends Reducer<Text, Text, Text, IntWritable> {

        private IntWritable result = new IntWritable();

        public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
            Map<Integer, Integer> mValues = new HashMap<>();
            Map<Integer, Integer> nValues = new HashMap<>();
            for (Text val : values) {
                String[] tokens = val.toString().split(",");
                if (tokens[0].equals("M")) {
                    mValues.put(Integer.parseInt(tokens[1]), Integer.parseInt(tokens[2]));
                } else if (tokens[0].equals("N")) {
                    nValues.put(Integer.parseInt(tokens[1]), Integer.parseInt(tokens[2]));
                }
            }
            int sum = 0;
            for (Map.Entry<Integer, Integer> entry : mValues.entrySet()) {
                int k = entry.getKey();
                int mVal = entry.getValue();
                int nVal = nValues.containsKey(k) ? nValues.get(k) : 0;
                sum += mVal * nVal;
                
            }
            result.set(sum);
            context.write(key, result);
        }
    }

    public static void main(String[] args) throws Exception {
    	 Configuration conf = new Configuration();
         Job job = Job.getInstance(conf, "Matrix Multiplication");
         job.setJarByClass(MatrixMultiplication.class);
         job.setMapperClass(MatrixMapper.class);
         job.setReducerClass(MatrixReducer.class);
         job.setOutputKeyClass(Text.class);
         job.setOutputValueClass(Text.class);
         FileInputFormat.addInputPath(job, new Path(args[0]));
         FileOutputFormat.setOutputPath(job, new Path(args[1]));
         System.exit(job.waitForCompletion(true) ? 0 : 1);
     }
 }


    
after this export jar  (matrix_multiply)
