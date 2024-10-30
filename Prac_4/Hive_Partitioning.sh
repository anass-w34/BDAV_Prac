Contents of employee_partition_2023.csv
This file contains employee data for the year 2023.
1,John Doe,30,Engineering,60000.00,2023-01-15,USA
2,Jane Smith,28,Marketing,55000.00,2023-03-20,Canada
3,Alex Brown,35,Sales,70000.00,2023-06-11,UK

Contents of employee_partition_2024.csv
This file contains employee data for the year 2024.
4,Emily Clark,32,Engineering,62000.00,2024-02-18,USA
5,Michael Johnson,40,Marketing,78000.00,2024-04-12,Australia
6,Sarah Wilson,29,IT,65000.00,2024-05-23,India


********************************** Steps to Use These Files *********************************************
1) Save the Content:
Save each dataset in separate CSV files with names employee_partition_2023.csv and employee_partition_2024.csv.
2) Upload Files to HDFS:
Place these files in their respective directories in HDFS:
hdfs dfs -put /path/to/employee_partition_2023.csv /user/cloudera/employee/2023/
hdfs dfs -put /path/to/employee_partition_2024.csv /user/cloudera/employee/2024/

3)Load Data into Hive Partitions:
Load the data into the employee_partitioned table for each year:
LOAD DATA INPATH '/user/cloudera/employee/2023/employee_partition_2023.csv' INTO TABLE employee_partitioned PARTITION (year=2023);
LOAD DATA INPATH '/user/cloudera/employee/2024/employee_partition_2024.csv' INTO TABLE employee_partitioned PARTITION (year=2024);



1) Create a Partitioned Table:
Employee Partitioned Table Schema:
CREATE TABLE employee_partitioned (
    emp_id INT,
    name STRING,
    age INT,
    department STRING,
    salary DECIMAL(10, 2),
    joining_date DATE,
    country STRING
) PARTITIONED BY (year INT)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

2)Add Partitions:
Add partitions based on year values:
ALTER TABLE employee_partitioned ADD PARTITION (year=2023) LOCATION '/user/cloudera/employee/2023';
ALTER TABLE employee_partitioned ADD PARTITION (year=2024) LOCATION '/user/cloudera/employee/2024';


3)Load Data into Partitioned Table:
Load the data into each partition directory in HDFS (/user/cloudera/employee/2023 and /user/cloudera/employee/2024), then load them into Hive using:
LOAD DATA INPATH '/user/cloudera/employee/2023/employee_partition_2023.csv' INTO TABLE employee_partitioned PARTITION (year=2023);
LOAD DATA INPATH '/user/cloudera/employee/2024/employee_partition_2024.csv' INTO TABLE employee_partitioned PARTITION (year=2024);

4) Query Partitioned Table:
Select data for a specific partition:
SELECT * FROM employee_partitioned WHERE year = 2023;


**************************************** [ TERMINAL ]************************************************************************************************

[cloudera@quickstart Prac_4]$ performing partioning step here 
bash: performing: command not found
[cloudera@quickstart Prac_4]$ pwd
/home/cloudera/Prac_4

[cloudera@quickstart Prac_4]$ hdfs dfs -mkdir /employee_partition_2023
[cloudera@quickstart Prac_4]$ hdfs dfs -put /home/cloudera/Prac_4/employee_partition_2023.csv /employee_partition_2023
[cloudera@quickstart Prac_4]$ hdfs dfs -mkdir /employee_partition_2024
[cloudera@quickstart Prac_4]$ hdfs dfs -put /home/cloudera/Prac_4/employee_partition_2024.csv /employee_partition_2024
[cloudera@quickstart Prac_4]$ sudo service zookeeper-server start
JMX enabled by default
Using config: /etc/zookeeper/conf/zoo.cfg
Starting zookeeper ... already running as process 5296.
[cloudera@quickstart Prac_4]$ sudo service hive-server2 start
Hive Server2 is running                                    [  OK  ]
[cloudera@quickstart Prac_4]$ sudo hive

Logging initialized using configuration in file:/etc/hive/conf.dist/hive-log4j.properties
WARNING: Hive CLI is deprecated and migration to Beeline is recommended.
hive> CREATE TABLE employee_partitioned (
    >     emp_id INT,
    >     name STRING,
    >     age INT,
    >     department STRING,
    >     salary DECIMAL(10, 2),
    >     joining_date DATE,
    >     country STRING
    > ) PARTITIONED BY (year INT)
    > ROW FORMAT DELIMITED 
    > FIELDS TERMINATED BY ',' 
    > STORED AS TEXTFILE;
OK
Time taken: 5.826 seconds

hive> ALTER TABLE employee_partitioned ADD PARTITION (year=2023) LOCATION '/user/cloudera/employee/2023';
OK
Time taken: 1.437 seconds

hive> ALTER TABLE employee_partitioned ADD PARTITION (year=2024) LOCATION '/user/cloudera/employee/2024';
OK
Time taken: 0.735 seconds

hive> LOAD DATA INPATH '/employee_partition_2023/employee_partition_2023.csv' INTO TABLE employee_partitioned PARTITION (year=2023);
Loading data to table default.employee_partitioned partition (year=2023)
Partition default.employee_partitioned{year=2023} stats: [numFiles=1, totalSize=148]
OK
Time taken: 4.929 seconds


hive> LOAD DATA INPATH '/employee_partition_2024/employee_partition_2024.csv' INTO TABLE employee_partitioned PARTITION (year=2024);
Loading data to table default.employee_partitioned partition (year=2024)
Partition default.employee_partitioned{year=2024} stats: [numFiles=1, totalSize=161]
OK
Time taken: 2.569 seconds


hive> SELECT * FROM employee_partitioned WHERE year = 2023;
OK
1	John Doe	30	Engineering	60000	2023-01-15	USA	2023
2	Jane Smith	28	Marketing	55000	2023-03-20	Canada	2023
3	Alex Brown	35	Sales	70000	2023-06-11	UK	2023
Time taken: 8.07 seconds, Fetched: 3 row(s)
hive> SELECT * FROM employee_partitioned WHERE year = 2024;
OK
4	Emily Clark	32	Engineering	62000	2024-02-18	USA	2024
5	Michael Johnson	40	Marketing	78000	2024-04-12	Australia	2024
6	Sarah Wilson	29	IT	65000	2024-05-23	India	2024
Time taken: 0.4 seconds, Fetched: 3 row(s)
hive> 

