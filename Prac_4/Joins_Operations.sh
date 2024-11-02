7. Performing Join Operations in Hive

1) Create a Second Table for Join:
Create another table named department to store department-related data:
CREATE TABLE department (
    dept_id INT,
    dept_name STRING,
    location STRING
) ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;


Example Content (save as department.csv and upload to HDFS):
1,IT,New York
2,HR,Los Angeles
3,Sales,Chicago
4,Marketing,Boston

[cloudera@quickstart Prac_4]$ hdfs dfs -mkdir /prac_4_department
[cloudera@quickstart Prac_4]$ hdfs dfs -put /home/cloudera/Prac_4/department.csv /prac_4_department
[cloudera@quickstart Prac_4]$ hdfs dfs -ls /prac_4_department

*****************************************************************************
[cloudera@quickstart Prac_4]$ sudo service zookeeper-server start

[cloudera@quickstart Prac_4]$ sudo service hive-server2 start
                                
[cloudera@quickstart Prac_4]$ sudo hive

hive> SHOW DATABASES;
OK
default
user1
Time taken: 2.84 seconds, Fetched: 2 row(s)

hive> USE user1;
OK
Time taken: 0.227 seconds

hive> SHOW TABLES;
OK
employee49
Time taken: 0.388 seconds, Fetched: 1 row(s)
**************************************************************************************
LOAD DATA INPATH '/prac_4_department/department.csv' INTO TABLE department;




2) Inner Join:
Perform an inner join between employee49 and department tables on the department column:
SELECT e.emp_id, e.name, d.dept_name, e.salary 
FROM employee49 e 
JOIN department d ON e.department = d.dept_name;

3) Left Join:
Perform a left join to include all employees, even if they don’t have a matching department in the department table:
SELECT e.emp_id, e.name, d.dept_name, e.salary 
FROM employee49 e 
LEFT JOIN department d ON e.department = d.dept_name;

4) Right Join:
Perform a right join to include all departments, even if no employees are associated with them: 
SELECT e.emp_id, e.name, d.dept_name, e.salary 
FROM employee49 e 
RIGHT JOIN department d ON e.department = d.dept_name;

----------------------- TERMINAL -----------------------------------------------------------------------------

[cloudera@quickstart Prac_4]$ pwd
/home/cloudera/Prac_4
[cloudera@quickstart Prac_4]$ hdfs dfs -ls /
Found 15 items
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 00:34 /Prac_2
drwxr-xr-x   - cloudera supergroup          0 2024-10-28 23:02 /anadfolder
drwxrwxrwx   - hdfs     supergroup          0 2017-10-23 09:15 /benchmarks
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 23:14 /destination_1_prac_1
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 22:47 /destination_2_prac_1
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 23:11 /employee_partition_2023
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 23:12 /employee_partition_2024
drwxr-xr-x   - hbase    supergroup          0 2024-10-29 22:14 /hbase
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 08:57 /matrix_multiplication_1
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 00:48 /output_prac_2
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 22:54 /prac_4
drwxr-xr-x   - solr     solr                0 2017-10-23 09:18 /solr
drwxrwxrwt   - hdfs     supergroup          0 2024-10-28 01:13 /tmp
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /user
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /var
[cloudera@quickstart Prac_4]$ hdfs dfs -ls /prac_4
[cloudera@quickstart Prac_4]$ hdfs dfs -mkdir /prac_4_department
[cloudera@quickstart Prac_4]$ hdfs dfs -put /home/cloudera/Prac_4/department.csv /prac_4_department
[cloudera@quickstart Prac_4]$ hdfs dfs -ls /prac_4_departmentFound 1 items
-rw-r--r--   1 cloudera supergroup         66 2024-10-30 00:17 /prac_4_department/department.csv
[cloudera@quickstart Prac_4]$ hdfs dfs -cat /prac_4_department/department.csv
1,IT,New York
2,HR,Los Angeles
3,Sales,Chicago
4,Marketing,Boston

[cloudera@quickstart Prac_4]$ sudo service zookeeper-server start
JMX enabled by default
Using config: /etc/zookeeper/conf/zoo.cfg
Starting zookeeper ... already running as process 5296.
[cloudera@quickstart Prac_4]$ sudo service hive-server2 start
Hive Server2 is running                                    [  OK  ]
[cloudera@quickstart Prac_4]$ sudo hive

Logging initialized using configuration in file:/etc/hive/conf.dist/hive-log4j.properties
WARNING: Hive CLI is deprecated and migration to Beeline is recommended.

hive> SHOW DATABASES;
OK
default
user1
Time taken: 2.84 seconds, Fetched: 2 row(s)

hive> USE user1;
OK
Time taken: 0.227 seconds

hive> SHOW TABLES;
OK
employee49
Time taken: 0.388 seconds, Fetched: 1 row(s)

hive> CREATE TABLE department (
    >     dept_id INT,
    >     dept_name STRING,
    >     location STRING
    > ) ROW FORMAT DELIMITED 
    > FIELDS TERMINATED BY ',' 
    > STORED AS TEXTFILE;
OK
Time taken: 2.815 seconds

hive> LOAD DATA INPATH '/prac_4_department/department.csv' INTO TABLE department;
Loading data to table user1.department
Table user1.department stats: [numFiles=1, totalSize=66]
OK
Time taken: 3.512 seconds

hive> SHOW DATABASES;
OK
default
user1
Time taken: 2.852 seconds, Fetched: 2 row(s)

hive> USE user1;
OK
Time taken: 0.252 seconds

hive> SHOW TABLES;
OK
department
employee49
Time taken: 0.231 seconds, Fetched: 2 row(s)

------- INNER JOIN ---------------------------------------------

hive> SELECT e.emp_id, e.name, d.dept_name, e.salary 
    > FROM employee49 e 
    > JOIN department d ON e.department = d.dept_name;
Query ID = root_20241030002525_5c488cfa-3f3b-4ed1-b382-38d562962272
Total jobs = 1
Execution log at: /tmp/root/root_20241030002525_5c488cfa-3f3b-4ed1-b382-38d562962272.log
2024-10-30 12:25:59	Starting to launch local task to process map join;	maximum memory = 1013645312
2024-10-30 12:26:07	Dump the side-table for tag: 1 with group count: 4 into file: file:/tmp/root/6e90426a-840a-4a5a-b525-7b125b4df066/hive_2024-10-30_00-25-21_866_3138985291479361225-1/-local-10003/HashTable-Stage-3/MapJoin-mapfile01--.hashtable
2024-10-30 12:26:07	Uploaded 1 File to: file:/tmp/root/6e90426a-840a-4a5a-b525-7b125b4df066/hive_2024-10-30_00-25-21_866_3138985291479361225-1/-local-10003/HashTable-Stage-3/MapJoin-mapfile01--.hashtable (350 bytes)
2024-10-30 12:26:07	End of local task; Time Taken: 7.96 sec.
Execution completed successfully
MapredLocal task succeeded
Launching Job 1 out of 1
Number of reduce tasks is set to 0 since there's no reduce operator
Starting Job = job_1730264742866_0003, Tracking URL = http://quickstart.cloudera:8088/proxy/application_1730264742866_0003/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1730264742866_0003
Hadoop job information for Stage-3: number of mappers: 1; number of reducers: 0
2024-10-30 00:27:06,878 Stage-3 map = 0%,  reduce = 0%
2024-10-30 00:27:51,587 Stage-3 map = 100%,  reduce = 0%, Cumulative CPU 5.89 sec
MapReduce Total cumulative CPU time: 5 seconds 890 msec
Ended Job = job_1730264742866_0003
MapReduce Jobs Launched: 
Stage-Stage-3: Map: 1   Cumulative CPU: 5.89 sec   HDFS Read: 7270 HDFS Write: 90 SUCCESS
Total MapReduce CPU Time Spent: 5 seconds 890 msec
OK
1	Raj	IT	50000
2	Sita	HR	60000
3	Ravi	IT	55000
4	Priya	Sales	48000
5	Arun	Marketing	75000
Time taken: 153.631 seconds, Fetched: 5 row(s)

-----------------------------------------   LEFT JOIN -------------------------------------------------------------------

hive> SELECT e.emp_id, e.name, d.dept_name, e.salary 
    > FROM employee49 e 
    > LEFT JOIN department d ON e.department = d.dept_name;
Query ID = root_20241030002727_55139e4d-632d-40aa-886c-6e0f6e5e4366
Total jobs = 1
Execution log at: /tmp/root/root_20241030002727_55139e4d-632d-40aa-886c-6e0f6e5e4366.log
2024-10-30 12:28:34	Starting to launch local task to process map join;	maximum memory = 1013645312
2024-10-30 12:28:39	Dump the side-table for tag: 1 with group count: 4 into file: file:/tmp/root/6e90426a-840a-4a5a-b525-7b125b4df066/hive_2024-10-30_00-27-59_130_1675742952239327173-1/-local-10003/HashTable-Stage-3/MapJoin-mapfile11--.hashtable
2024-10-30 12:28:39	Uploaded 1 File to: file:/tmp/root/6e90426a-840a-4a5a-b525-7b125b4df066/hive_2024-10-30_00-27-59_130_1675742952239327173-1/-local-10003/HashTable-Stage-3/MapJoin-mapfile11--.hashtable (350 bytes)
2024-10-30 12:28:39	End of local task; Time Taken: 4.828 sec.
Execution completed successfully
MapredLocal task succeeded
Launching Job 1 out of 1
Number of reduce tasks is set to 0 since there's no reduce operator
Starting Job = job_1730264742866_0004, Tracking URL = http://quickstart.cloudera:8088/proxy/application_1730264742866_0004/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1730264742866_0004
Hadoop job information for Stage-3: number of mappers: 1; number of reducers: 0
2024-10-30 00:29:35,214 Stage-3 map = 0%,  reduce = 0%
2024-10-30 00:29:58,784 Stage-3 map = 100%,  reduce = 0%, Cumulative CPU 2.51 sec
MapReduce Total cumulative CPU time: 2 seconds 510 msec
Ended Job = job_1730264742866_0004
MapReduce Jobs Launched: 
Stage-Stage-3: Map: 1   Cumulative CPU: 2.51 sec   HDFS Read: 7242 HDFS Write: 90 SUCCESS
Total MapReduce CPU Time Spent: 2 seconds 510 msec
OK
1	Raj	IT	50000
2	Sita	HR	60000
3	Ravi	IT	55000
4	Priya	Sales	48000
5	Arun	Marketing	75000
Time taken: 122.073 seconds, Fetched: 5 row(s)


------------------------------------------ RIGHT JOIN -------------------------------------------

hive> SELECT e.emp_id, e.name, d.dept_name, e.salary 
    > FROM employee49 e 
    > RIGHT JOIN department d ON e.department = d.dept_name;
Query ID = root_20241030003030_00011653-35d5-43aa-8861-6c4db204e8b7
Total jobs = 1
Execution log at: /tmp/root/root_20241030003030_00011653-35d5-43aa-8861-6c4db204e8b7.log
2024-10-30 12:30:21	Starting to launch local task to process map join;	maximum memory = 1013645312
2024-10-30 12:30:25	Dump the side-table for tag: 0 with group count: 4 into file: file:/tmp/root/6e90426a-840a-4a5a-b525-7b125b4df066/hive_2024-10-30_00-30-05_929_1560043422673160005-1/-local-10003/HashTable-Stage-3/MapJoin-mapfile20--.hashtable
2024-10-30 12:30:25	Uploaded 1 File to: file:/tmp/root/6e90426a-840a-4a5a-b525-7b125b4df066/hive_2024-10-30_00-30-05_929_1560043422673160005-1/-local-10003/HashTable-Stage-3/MapJoin-mapfile20--.hashtable (414 bytes)
2024-10-30 12:30:25	End of local task; Time Taken: 4.138 sec.
Execution completed successfully
MapredLocal task succeeded
Launching Job 1 out of 1
Number of reduce tasks is set to 0 since there's no reduce operator
Starting Job = job_1730264742866_0005, Tracking URL = http://quickstart.cloudera:8088/proxy/application_1730264742866_0005/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1730264742866_0005
Hadoop job information for Stage-3: number of mappers: 1; number of reducers: 0
2024-10-30 00:30:51,290 Stage-3 map = 0%,  reduce = 0%
2024-10-30 00:31:09,854 Stage-3 map = 100%,  reduce = 0%, Cumulative CPU 1.92 sec
MapReduce Total cumulative CPU time: 1 seconds 920 msec
Ended Job = job_1730264742866_0005
MapReduce Jobs Launched: 
Stage-Stage-3: Map: 1   Cumulative CPU: 1.92 sec   HDFS Read: 6999 HDFS Write: 90 SUCCESS
Total MapReduce CPU Time Spent: 1 seconds 920 msec
OK
1	Raj	IT	50000
3	Ravi	IT	55000
2	Sita	HR	60000
4	Priya	Sales	48000
5	Arun	Marketing	75000
Time taken: 67.709 seconds, Fetched: 5 row(s)
hive> 





