
open cloudera create prat2 folder then right click open in terminal then write pwd 
[cloudera@quickstart Prac_2]$ ls
WordCount.jar
[cloudera@quickstart Prac_2]$ pwd
/home/cloudera/Prac_2    [  // prac_2 folder maine create kiya tha mouse right click karke - new folder mai jaake ]

___________________________________________________________

Step 1: Set up Directories and Input Files
Create a new folder for the practical files:
[cloudera@quickstart ~]$ mkdir Prac_2

Navigate to the folder:
[cloudera@quickstart ~]$ cd Prac_2

[cloudera@quickstart Prac_2]$ pwd


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


************************************************************* (proceed with eclipse part refer steps.sh) PART 2 ( NEW TERMINAL ) *********************************************************************************

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
