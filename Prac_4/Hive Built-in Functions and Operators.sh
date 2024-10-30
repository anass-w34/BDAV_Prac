****************************** Hive Built-in Functions and Operators ***********************************
String Functions:
Concatenate name and department:
SELECT CONCAT(name, ' - ', department) AS emp_info FROM employee49;

Date Functions:
Extract the year from joining_date:
SELECT emp_id, name, YEAR(joining_date) AS join_year FROM employee49;

Mathematical Functions:
Round the salary column:
SELECT emp_id, ROUND(salary, 0) AS rounded_salary FROM employee49;


Operators:
Apply arithmetic and logical operators:
SELECT emp_id, salary * 1.1 AS new_salary FROM employee49;
SELECT * FROM employee49 WHERE salary >= 50000 AND department = 'IT';

--------------------------- TERMINAL ------------------------------------

[cloudera@quickstart Prac_4]$ pwd
/home/cloudera/Prac_4
[cloudera@quickstart Prac_4]$ 3. Hive Built-in Functions and Operators
bash: 3.: command not found
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
Time taken: 3.403 seconds, Fetched: 2 row(s)
hive> USE user1;
OK
Time taken: 0.209 seconds
hive> SHOW TABLES;
OK
employee49
Time taken: 1.089 seconds, Fetched: 1 row(s)
hive> SELECT CONCAT(name, ' - ', department) AS emp_info FROM employee49;
OK
Raj - IT
Sita - HR
Ravi - IT
Priya - Sales
Arun - Marketing
Time taken: 4.971 seconds, Fetched: 5 row(s)
hive> SELECT emp_id, name, YEAR(joining_date) AS join_year FROM employee49;
OK
1	Raj	2021
2	Sita	2020
3	Ravi	2019
4	Priya	2022
5	Arun	2018
Time taken: 0.512 seconds, Fetched: 5 row(s)
hive> SELECT emp_id, ROUND(salary, 0) AS rounded_salary FROM employee49;
OK
1	50000
2	60000
3	55000
4	48000
5	75000
Time taken: 0.612 seconds, Fetched: 5 row(s)
hive> SELECT emp_id, salary * 1.1 AS new_salary FROM employee49;
OK
1	55000.00000000001
2	66000.0
3	60500.00000000001
4	52800.00000000001
5	82500.0
Time taken: 0.649 seconds, Fetched: 5 row(s)
hive> SELECT * FROM employee49 WHERE salary >= 50000 AND department = 'IT';
OK
1	Raj	28	IT	50000	2021-01-10	India
3	Ravi	30	IT	55000	2019-05-22	India
Time taken: 1.224 seconds, Fetched: 2 row(s)
hive> 



