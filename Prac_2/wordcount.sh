
open cloudera create prat2 folder then right click open in terminal then write pwd
[cloudera@quickstart Prac_2]$ ls
WordCount.jar
[cloudera@quickstart Prac_2]$ pwd
/home/cloudera/Prac_2    [  // prac_2 folder maine create kiya tha mouse right click karke - new folder mai jaake ]

[cloudera@quickstart Prac_2]$ cat > /home/cloudera/Prac_2/Processfile1.txt   [ command for creating a processfile1 .txt file in folder prac_2 ]
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
Riyaz Ahamed   [ press ctrl + d to save the file ] 
[cloudera@quickstart Prac_2]$ cat /home/cloudera/Prac_2/Processfile1.txt  [ command for reading a processfile1 .txt file in folder prac_2  ] 
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
[cloudera@quickstart Prac_2]$ hdfs dfs -mkdir /Prac_2
[cloudera@quickstart Prac_2]$ hdfs dfs -ls /
Found 10 items
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 00:31 /Prac_2
drwxr-xr-x   - cloudera supergroup          0 2024-10-28 23:02 /anadfolder
drwxrwxrwx   - hdfs     supergroup          0 2017-10-23 09:15 /benchmarks
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 23:14 /destination_1_prac_1
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 22:47 /destination_2_prac_1
drwxr-xr-x   - hbase    supergroup          0 2024-10-28 01:43 /hbase
drwxr-xr-x   - solr     solr                0 2017-10-23 09:18 /solr
drwxrwxrwt   - hdfs     supergroup          0 2024-10-28 01:13 /tmp
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /user
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /var


[cloudera@quickstart Prac_2]$ hdfs dfs -put /home/cloudera/Prac_2/Processfile1.txt /Prac_2  [ command for copy a local file to hdfs directory ] 
[cloudera@quickstart Prac_2]$ hdfs dfs -ls /Prac_2
Found 1 items
-rw-r--r--   1 cloudera supergroup        128 2024-10-29 00:34 /Prac_2/Processfile1.txt

[cloudera@quickstart Prac_2]$ hdfs dfs -cat /Prac_2/Processfile1.txt         [ command for reading a file in hdfs directory ] 
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
[cloudera@quickstart Prac_2]$ 


************************************************************* PART 2 ( NEW TERMINAL ) *********************************************************************************

[cloudera@quickstart ~]$ pwd
/home/cloudera
[cloudera@quickstart ~]$ hadoop jar /home/cloudera/Prac_2/WordCount.jar wordcount/WordCount /Prac_2/Processfile1.txt /output_prac_2  
( syntax : hadoop jar /cloudera_local_directory_path/jar file name  package_name/Class_name /hdfs_directory_name/hdfs_directory_file_name/ (yeh file automatic generate hoti hai ) output_directory_name ) 

24/10/29 00:44:14 INFO client.RMProxy: Connecting to ResourceManager at /0.0.0.0:8032
24/10/29 00:44:25 WARN mapreduce.JobResourceUploader: Hadoop command-line option parsing not performed. Implement the Tool interface and execute your application with ToolRunner to remedy this.
24/10/29 00:44:30 INFO input.FileInputFormat: Total input paths to process : 1
24/10/29 00:44:31 INFO mapreduce.JobSubmitter: number of splits:1
24/10/29 00:44:37 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1730104666546_0001
24/10/29 00:44:47 INFO impl.YarnClientImpl: Submitted application application_1730104666546_0001
24/10/29 00:44:47 INFO mapreduce.Job: The url to track the job: http://quickstart.cloudera:8088/proxy/application_1730104666546_0001/
24/10/29 00:44:47 INFO mapreduce.Job: Running job: job_1730104666546_0001
24/10/29 00:46:29 INFO mapreduce.Job: Job job_1730104666546_0001 running in uber mode : false
24/10/29 00:46:29 INFO mapreduce.Job:  map 0% reduce 0%
24/10/29 00:47:47 INFO mapreduce.Job:  map 100% reduce 0%
24/10/29 00:48:37 INFO mapreduce.Job:  map 100% reduce 100%
24/10/29 00:48:40 INFO mapreduce.Job: Job job_1730104666546_0001 completed successfully
24/10/29 00:48:42 INFO mapreduce.Job: Counters: 49
	File System Counters
		FILE: Number of bytes read=82
		FILE: Number of bytes written=286933
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
		HDFS: Number of bytes read=248
		HDFS: Number of bytes written=52
		HDFS: Number of read operations=6
		HDFS: Number of large read operations=0
		HDFS: Number of write operations=2
	Job Counters 
		Launched map tasks=1
		Launched reduce tasks=1
		Data-local map tasks=1
		Total time spent by all maps in occupied slots (ms)=77140
		Total time spent by all reduces in occupied slots (ms)=45296
		Total time spent by all map tasks (ms)=77140
		Total time spent by all reduce tasks (ms)=45296
		Total vcore-milliseconds taken by all map tasks=77140
		Total vcore-milliseconds taken by all reduce tasks=45296
		Total megabyte-milliseconds taken by all map tasks=78991360
		Total megabyte-milliseconds taken by all reduce tasks=46383104
	Map-Reduce Framework
		Map input records=12
		Map output records=20
		Map output bytes=208
		Map output materialized bytes=82
		Input split bytes=120
		Combine input records=20
		Combine output records=6
		Reduce input groups=6
		Reduce shuffle bytes=82
		Reduce input records=6
		Reduce output records=6
		Spilled Records=12
		Shuffled Maps =1
		Failed Shuffles=0
		Merged Map outputs=1
		GC time elapsed (ms)=1638
		CPU time spent (ms)=8000
		Physical memory (bytes) snapshot=345632768
		Virtual memory (bytes) snapshot=3021582336
		Total committed heap usage (bytes)=226365440
	Shuffle Errors
		BAD_ID=0
		CONNECTION=0
		IO_ERROR=0
		WRONG_LENGTH=0
		WRONG_MAP=0
		WRONG_REDUCE=0
	File Input Format Counters 
		Bytes Read=128
	File Output Format Counters 
		Bytes Written=52
[cloudera@quickstart ~]$ hdfs dfs -ls /
Found 11 items
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 00:34 /Prac_2
drwxr-xr-x   - cloudera supergroup          0 2024-10-28 23:02 /anadfolder
drwxrwxrwx   - hdfs     supergroup          0 2017-10-23 09:15 /benchmarks
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 23:14 /destination_1_prac_1
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 22:47 /destination_2_prac_1
drwxr-xr-x   - hbase    supergroup          0 2024-10-28 01:43 /hbase
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 00:48 /output_prac_2
drwxr-xr-x   - solr     solr                0 2017-10-23 09:18 /solr
drwxrwxrwt   - hdfs     supergroup          0 2024-10-28 01:13 /tmp
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /user
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /var


[cloudera@quickstart ~]$ hdfs dfs -ls /output_prac_2
Found 2 items
-rw-r--r--   1 cloudera supergroup          0 2024-10-29 00:48 /output_prac_2/_SUCCESS
-rw-r--r--   1 cloudera supergroup         52 2024-10-29 00:48 /output_prac_2/part-r-00000
[cloudera@quickstart ~]$ hdfs dfs -cat /output_prac_2/part-r-00000    [ command for reading a file in  hdfs directory ] 
Ahamed	5
Big	3
Cloudera	2
Data	3
Riyaz	5
cloudera	2
[cloudera@quickstart ~]$ 


***********************************************************************************************************************************************************
imp command :
pwd 
ls 
[cloudera@quickstart Prac_2]$ cat > /home/cloudera/Prac_2/Processfile1.txt   [ command for creating a processfile1 .txt file in folder prac_2 ]
[cloudera@quickstart Prac_2]$ cat /home/cloudera/Prac_2/Processfile1.txt  [ command for reading a processfile1 .txt file in folder prac_2  ] 
[cloudera@quickstart Prac_2]$ hdfs dfs -put /home/cloudera/Prac_2/Processfile1.txt /Prac_2  [ command for copy a local file to hdfs directory ] 
[cloudera@quickstart Prac_2]$ hdfs dfs -cat /Prac_2/Processfile1.txt         [ command for reading a file in hdfs directory ] 
