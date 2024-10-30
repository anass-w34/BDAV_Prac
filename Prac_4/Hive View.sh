1)Create a View:
Create a view to display employees with salaries over 50,000:
CREATE VIEW emp_view AS 
SELECT emp_id, name, department 
FROM employee49 
WHERE salary > 50000;

2)Query the View:
Select data from the view:
SELECT * FROM emp_view;

3) Drop the View:
Remove the view if needed:
DROP VIEW IF EXISTS emp_view;

--------------- TERMINAL -------------------------------------------------
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
Time taken: 2.637 seconds, Fetched: 2 row(s)

hive> USE user1;
OK
Time taken: 0.195 seconds

hive> SHOW TABLES;
OK
employee49
Time taken: 0.385 seconds, Fetched: 1 row(s)


hive> CREATE VIEW emp_view AS 
    > SELECT emp_id, name, department 
    > FROM employee49 
    > WHERE salary > 50000;
OK
Time taken: 2.584 seconds


hive> SELECT * FROM emp_view;
OK
2	Sita	HR
3	Ravi	IT
5	Arun	Marketing
Time taken: 1.932 seconds, Fetched: 3 row(s)


hive> DROP VIEW IF EXISTS emp_view;
OK
Time taken: 3.75 seconds
hive> 

