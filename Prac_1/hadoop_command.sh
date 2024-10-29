[cloudera@quickstart Prac_1]$ hadoop version
Hadoop 2.6.0-cdh5.13.0
Subversion http://github.com/cloudera/hadoop -r 42e8860b182e55321bd5f5605264da4adc8882be
Compiled by jenkins on 2017-10-04T18:08Z
Compiled with protoc 2.5.0
From source with checksum 5e84c185f8a22158e2b0e4b8f85311
This command was run using /usr/lib/hadoop/hadoop-common-2.6.0-cdh5.13.0.jar


[cloudera@quickstart Prac_1]$ hadoop fs -mkdir /anadfolder
[cloudera@quickstart Prac_1]$ hadoop fs -ls /
Found 7 items
drwxr-xr-x   - cloudera supergroup          0 2024-10-28 22:41 /anadfolder
drwxrwxrwx   - hdfs     supergroup          0 2017-10-23 09:15 /benchmarks
drwxr-xr-x   - hbase    supergroup          0 2024-10-28 01:43 /hbase
drwxr-xr-x   - solr     solr                0 2017-10-23 09:18 /solr
drwxrwxrwt   - hdfs     supergroup          0 2024-10-28 01:13 /tmp
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /user
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /var


[cloudera@quickstart Prac_1]$ hadoop fs -put ~/test.txt /filecopyfromlocal.txt
[cloudera@quickstart Prac_1]$ hadoop fs -ls /
Found 8 items
drwxr-xr-x   - cloudera supergroup          0 2024-10-28 22:41 /anadfolder
drwxrwxrwx   - hdfs     supergroup          0 2017-10-23 09:15 /benchmarks
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 22:47 /filecopyfromlocal.txt
drwxr-xr-x   - hbase    supergroup          0 2024-10-28 01:43 /hbase
drwxr-xr-x   - solr     solr                0 2017-10-23 09:18 /solr
drwxrwxrwt   - hdfs     supergroup          0 2024-10-28 01:13 /tmp
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /user
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /var


[cloudera@quickstart Prac_1]$ hadoop fs -count /
          82          942          861289309 /
          
[cloudera@quickstart Prac_1]$ hadoop fs -count -h /
          82          942            821.4 M /
          
[cloudera@quickstart Prac_1]$ hadoop fs -cat /filecopyfromlocal.txt
hii anas

[cloudera@quickstart Prac_1]$ hadoop fs -touchz /anadfolder/prac_1_touch_test.txt

[cloudera@quickstart Prac_1]$ hadoop fs -stat %b /filecopyfromlocal.txt
9
[cloudera@quickstart Prac_1]$ hadoop fs -stat %q /filecopyfromlocal.txt
q
[cloudera@quickstart Prac_1]$ hadoop fs -stat %g /filecopyfromlocal.txt
supergroup
[cloudera@quickstart Prac_1]$ hadoop fs -stat %n /filecopyfromlocal.txt
filecopyfromlocal.txt
[cloudera@quickstart Prac_1]$ hadoop fs -stat %o /filecopyfromlocal.txt
134217728
[cloudera@quickstart Prac_1]$ hadoop fs -stat %r /filecopyfromlocal.txt
1
[cloudera@quickstart Prac_1]$ hadoop fs -stat %u /filecopyfromlocal.txt
cloudera
[cloudera@quickstart Prac_1]$ hadoop fs -stat %y /filecopyfromlocal.txt
2024-10-29 05:47:51
[cloudera@quickstart Prac_1]$ hadoop fs -checksum /filecopyfromlocal.txt
/filecopyfromlocal.txt	MD5-of-0MD5-of-512CRC32C	0000020000000000000000000f98fccb11d6d411b3c83962b46a2015

[cloudera@quickstart Prac_1]$ hadoop fs -usage ls
Usage: hadoop fs [generic options] -ls [-C] [-d] [-h] [-q] [-R] [-t] [-S] [-r] [-u] [<path> ...]


[cloudera@quickstart Prac_1]$ hadoop fs -cp /filecopyfromlocal.txt /destination_1_prac_1

[cloudera@quickstart Prac_1]$ hadoop fs -mv /filecopyfromlocal.txt /destination_1_prac_1
mv: `/destination_1_prac_1': File exists

[cloudera@quickstart Prac_1]$ hadoop fs -mv /filecopyfromlocal.txt /destination_2_prac_1

[cloudera@quickstart Prac_1]$ hadoop fs -ls /
Found 9 items
drwxr-xr-x   - cloudera supergroup          0 2024-10-28 23:02 /anadfolder
drwxrwxrwx   - hdfs     supergroup          0 2017-10-23 09:15 /benchmarks
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 23:14 /destination_1_prac_1
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 22:47 /destination_2_prac_1
drwxr-xr-x   - hbase    supergroup          0 2024-10-28 01:43 /hbase
drwxr-xr-x   - solr     solr                0 2017-10-23 09:18 /solr
drwxrwxrwt   - hdfs     supergroup          0 2024-10-28 01:13 /tmp
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /user
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /var
[cloudera@quickstart Prac_1]$ 


********************************************************************************************************************
note :

1) The hadoop fs -touchz command is used in Hadoop to create an empty file or update the timestamp of an existing file in HDFS (Hadoop Distributed File System). The syntax for the command is as follows:
syntax : hadoop fs -touchz <path_to_hdfs_file>
Example
To create an empty file named example.txt in the HDFS directory /user/hadoop/, you would use:
hadoop fs -touchz /user/hadoop/example.txt

2) The syntax for the hadoop fs -cp command, which is used to copy files or directories in HDFS, is as follows:
hadoop fs -cp <source_path> <destination_path>
Example
To copy a file from one location in HDFS to another, you would use:
hadoop fs -cp /user/hadoop/source.txt /user/hadoop/destination.txt

