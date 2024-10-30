5. Hive Index


1) Create an Index:
Create an index on the department column:
CREATE INDEX emp_idx ON TABLE employee49 (department) AS 'COMPACT' WITH DEFERRED REBUILD;

2) Drop the Index:
Drop the index if necessary:
DROP INDEX IF EXISTS emp_idx ON employee49;

------------------------- TERMINAL --------------------------------------------------------

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
Time taken: 3.695 seconds, Fetched: 2 row(s)

hive> USE user1;
OK
Time taken: 0.271 seconds

hive> SHOW Tables;
OK
employee49
Time taken: 0.157 seconds, Fetched: 1 row(s)

hive> CREATE INDEX emp_idx ON TABLE employee49 (department) AS 'COMPACT' WITH DEFERRED REBUILD;
OK
Time taken: 3.501 seconds

hive> DROP INDEX IF EXISTS emp_idx ON employee49;
OK
Time taken: 1.499 seconds





**************************************************************************************************
6. Sorting Data in Hive


1) Sort Data by Salary:
Sort the data in descending order of salary:
SELECT * FROM employee49 ORDER BY salary DESC;

2) Sort Data by Multiple Columns:
Sort data by department and then by age:
SELECT * FROM employee49 ORDER BY department, age;


-------------------------------------- TERMINAL -----------------------------------------------------------------------------

hive> SELECT * FROM employee49 ORDER BY salary DESC;
Query ID = root_20241029235959_5db56c56-d38c-4b70-8c26-cf9476a5c35f
Total jobs = 1
Launching Job 1 out of 1
Number of reduce tasks determined at compile time: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1730264742866_0001, Tracking URL = http://quickstart.cloudera:8088/proxy/application_1730264742866_0001/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1730264742866_0001
Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
2024-10-30 00:01:22,916 Stage-1 map = 0%,  reduce = 0%
2024-10-30 00:02:20,193 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 7.72 sec
2024-10-30 00:02:54,456 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 12.16 sec
MapReduce Total cumulative CPU time: 12 seconds 160 msec
Ended Job = job_1730264742866_0001
MapReduce Jobs Launched: 
Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 12.16 sec   HDFS Read: 9347 HDFS Write: 190 SUCCESS
Total MapReduce CPU Time Spent: 12 seconds 160 msec
OK
5	Arun	42	Marketing	75000	2018-07-03	India
2	Sita	35	HR	60000	2020-03-14	India
3	Ravi	30	IT	55000	2019-05-22	India
1	Raj	28	IT	50000	2021-01-10	India
4	Priya	29	Sales	48000	2022-02-19	India
Time taken: 199.368 seconds, Fetched: 5 row(s)


hive> SELECT * FROM employee49 ORDER BY department, age;
Query ID = root_20241030000303_ccb52dd3-5245-4bb7-a034-ec9d2589cc44
Total jobs = 1
Launching Job 1 out of 1
Number of reduce tasks determined at compile time: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1730264742866_0002, Tracking URL = http://quickstart.cloudera:8088/proxy/application_1730264742866_0002/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1730264742866_0002
Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
2024-10-30 00:04:02,651 Stage-1 map = 0%,  reduce = 0%
2024-10-30 00:04:40,829 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 5.77 sec
2024-10-30 00:05:10,888 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 9.24 sec
MapReduce Total cumulative CPU time: 9 seconds 240 msec
Ended Job = job_1730264742866_0002
MapReduce Jobs Launched: 
Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 9.24 sec   HDFS Read: 9509 HDFS Write: 190 SUCCESS
Total MapReduce CPU Time Spent: 9 seconds 240 msec
OK
2	Sita	35	HR	60000	2020-03-14	India
1	Raj	28	IT	50000	2021-01-10	India
3	Ravi	30	IT	55000	2019-05-22	India
5	Arun	42	Marketing	75000	2018-07-03	India
4	Priya	29	Sales	48000	2022-02-19	India
Time taken: 132.763 seconds, Fetched: 5 row(s)
hive> 





