
1. Remove Files from HDFS
Remove the CSV files and any other files uploaded to HDFS for this assignment.
# Remove employee.csv
hdfs dfs -rm /user/cloudera/employee.csv

# Remove department.csv if created
hdfs dfs -rm /user/cloudera/department.csv

# Remove partitioned files for 2023 and 2024
hdfs dfs -rm /user/cloudera/employee/2023/employee_partition_2023.csv
hdfs dfs -rm /user/cloudera/employee/2024/employee_partition_2024.csv

# Remove directories if empty
hdfs dfs -rmdir /user/cloudera/employee/2023
hdfs dfs -rmdir /user/cloudera/employee/2024
hdfs dfs -rmdir /user/cloudera/employee


2. Drop Database and All Tables in Hive
Switch to Hive CLI if not already in it:

hive
Use the Database:

USE User1;
Drop Tables:
Drop all tables created, such as employee49, employee_partitioned, department, and any tables created from select statements.

DROP TABLE IF EXISTS employee49;
DROP TABLE IF EXISTS employee_partitioned;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS emp49;
DROP TABLE IF EXISTS new_emp49;
DROP TABLE IF EXISTS updated_emp49;

Drop Views:
Drop any views created in the assignment.
DROP VIEW IF EXISTS emp_view;

Drop Indexes:
Drop any indexes created in the assignment.
DROP INDEX IF EXISTS emp_idx ON employee49;

Drop the Database:
After confirming all tables, views, and indexes are removed, you can drop the database.
DROP DATABASE IF EXISTS User1 CASCADE;


3. Confirm Removal
To confirm that everything has been removed:
Check that the HDFS directories have been deleted:
hdfs dfs -ls /user/cloudera/

In Hive CLI, verify that the database and tables are no longer present:
SHOW DATABASES;
