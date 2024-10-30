1) Prerequisites
Start Required Services:
Start Zookeeper, Hive, and any necessary services:
sudo service zookeeper-server start
sudo service hive-server2 start
sudo hive

2) Prepare and Upload employee.csv to HDFS:
Employee CSV Content:
1,Raj,28,IT,50000,2021-01-10,India
2,Sita,35,HR,60000,2020-03-14,India
3,Ravi,30,IT,55000,2019-05-22,India
4,Priya,29,Sales,48000,2022-02-19,India
5,Arun,42,Marketing,75000,2018-07-03,India

3)Upload to HDFS:
Save this content in a file named employee.csv and upload it to HDFS:
hdfs dfs -put /path/to/employee.csv /user/cloudera/employee.csv

[cloudera@quickstart Prac_4]$ hdfs dfs -ls /
Found 12 items
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 00:34 /Prac_2
drwxr-xr-x   - cloudera supergroup          0 2024-10-28 23:02 /anadfolder
drwxrwxrwx   - hdfs     supergroup          0 2017-10-23 09:15 /benchmarks
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 23:14 /destination_1_prac_1
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 22:47 /destination_2_prac_1
drwxr-xr-x   - hbase    supergroup          0 2024-10-29 22:14 /hbase
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 08:57 /matrix_multiplication_1
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 00:48 /output_prac_2
drwxr-xr-x   - solr     solr                0 2017-10-23 09:18 /solr
drwxrwxrwt   - hdfs     supergroup          0 2024-10-28 01:13 /tmp
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /user
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /var

[cloudera@quickstart Prac_4]$ hdfs dfs -mkdir /prac_4
[cloudera@quickstart Prac_4]$ hdfs dfs -put /home/cloudera/Prac_4/employee.csv /prac_4
[cloudera@quickstart Prac_4]$ hdfs dfs -ls /
Found 13 items
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 00:34 /Prac_2
drwxr-xr-x   - cloudera supergroup          0 2024-10-28 23:02 /anadfolder
drwxrwxrwx   - hdfs     supergroup          0 2017-10-23 09:15 /benchmarks
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 23:14 /destination_1_prac_1
-rw-r--r--   1 cloudera supergroup          9 2024-10-28 22:47 /destination_2_prac_1
drwxr-xr-x   - hbase    supergroup          0 2024-10-29 22:14 /hbase
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 08:57 /matrix_multiplication_1
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 00:48 /output_prac_2
drwxr-xr-x   - cloudera supergroup          0 2024-10-29 22:46 /prac_4
drwxr-xr-x   - solr     solr                0 2017-10-23 09:18 /solr
drwxrwxrwt   - hdfs     supergroup          0 2024-10-28 01:13 /tmp
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /user
drwxr-xr-x   - hdfs     supergroup          0 2017-10-23 09:17 /var

[cloudera@quickstart Prac_4]$ hdfs dfs -ls /prac_4
Found 1 items
-rw-r--r--   1 cloudera supergroup        190 2024-10-29 22:46 /prac_4/employee.csv
[cloudera@quickstart Prac_4]$ hdfs dfs -cat /prac_4/employee.csv
1,Raj,28,IT,50000,2021-01-10,India
2,Sita,35,HR,60000,2020-03-14,India
3,Ravi,30,IT,55000,2019-05-22,India
4,Priya,29,Sales,48000,2022-02-19,India
5,Arun,42,Marketing,75000,2018-07-03,India
[cloudera@quickstart Prac_4]$ 


*****************************  1. Creation of Database and Table in Hive **************************************************************************
1) Create a Database:
Create a new Hive database:
CREATE DATABASE User1;
SHOW DATABASES;

2) Use the Database:
Switch to the new database:
USE User1;

3) Create a Table:
Create a table for employee data:
CREATE TABLE employee49 (
    emp_id INT,
    name STRING,
    age INT,
    department STRING,
    salary DECIMAL(10, 2),
    joining_date DATE,
    country STRING
) ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

4)Load Data into the Table:
Load the employee.csv data from HDFS into employee49:
LOAD DATA INPATH '/user/cloudera/employee.csv' INTO TABLE employee49;

5)Verify Data Load:
Query the table to verify data loading:
SELECT * FROM employee49;

*********************** [TERMINAL] **************************************************

1) [cloudera@quickstart Prac_4]$ pwd
/home/cloudera/Prac_4
[cloudera@quickstart Prac_4]$ sudo service zookeeper-server start
JMX enabled by default
Using config: /etc/zookeeper/conf/zoo.cfg
Starting zookeeper ... already running as process 5296.
[cloudera@quickstart Prac_4]$ sudo service hive-server2 start
Hive Server2 is running                                    [  OK  ]
[cloudera@quickstart Prac_4]$ sudo hive
     
Logging initialized using configuration in file:/etc/hive/conf.dist/hive-log4j.properties
WARNING: Hive CLI is deprecated and migration to Beeline is recommended.

2) hive> CREATE DATABASE User1;
OK
Time taken: 22.314 seconds

3) hive> SHOW DATABASES;
OK
default
user1
Time taken: 1.968 seconds, Fetched: 2 row(s)

4) hive> USE User1;
OK
Time taken: 0.397 seconds

5) hive> CREATE TABLE employee49 (
    >     emp_id INT,
    >     name STRING,
    >     age INT,
    >     department STRING,
    >     salary DECIMAL(10, 2),
    >     joining_date DATE,
    >     country STRING
    > ) ROW FORMAT DELIMITED 
    > FIELDS TERMINATED BY ',' 
    > STORED AS TEXTFILE;
OK
Time taken: 2.742 seconds

6) hive> LOAD DATA INPATH '/prac_4/employee.csv' INTO TABLE employee49;
Loading data to table user1.employee49
Table user1.employee49 stats: [numFiles=1, totalSize=190]
OK
Time taken: 3.921 seconds


7) hive> SELECT * FROM employee49;
OK
1	Raj	28	IT	50000	2021-01-10	India
2	Sita	35	HR	60000	2020-03-14	India
3	Ravi	30	IT	55000	2019-05-22	India
4	Priya	29	Sales	48000	2022-02-19	India
5	Arun	42	Marketing	75000	2018-07-03	India
Time taken: 1.852 seconds, Fetched: 5 row(s)
hive> 
