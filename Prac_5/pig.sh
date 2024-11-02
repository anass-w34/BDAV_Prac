make prac_5 folder in cloudera local 

open terminal and create directory named prac_5 in hdfs. 
in terminal
cd prac_5
hdfs dfs -mkdir /prac_5


create files

Sample Data for data_model.csv:
John Doe;New York,10001;{(Math,85),(Science,90)};[1#85,2#90]
Jane Smith;Los Angeles,90001;{(Math,92),(Science,88)};[1#92,2#88]
 

Sample Data for sample_student_data.csv:
1,John,Doe,30,555-1234,New York
2,Jane,Smith,28,555-5678,Los Angeles
3,Alex,Brown,35,555-8765,Chicago

Upload Files to HDFS:
Place these files in a local directory, then upload to HDFS:
bash:
hdfs dfs -put /path/to/data_model.csv /user/cloudera/data_model.csv                 ex:  hdfs dfs -put /home/cloudera/prac_5/data_model.csv /prac_5/data_model.csv

hdfs dfs -put /path/to/sample_student_data.csv /user/cloudera/sample_student_data.csv    
ex: hdfs dfs -put /home/cloudera/prac_5/sample_student_data.csv /prac_5/sample_student_data.csv


*************************************************************************************************************************************************************************************************************************

 --------------------------------------------------------------------- Part 1: Pig Latin Basic ----------------------------------------------
open new terminal and start pig

[cloudera@quickstart ~]$ cd prac_5
[cloudera@quickstart prac_5]$ pig


1) a) Load data_model.csv for the data model
<pig terminal>

                 
 DataModels = LOAD '/prac_5/data_model.csv' USING PigStorage(';')                                         
             AS (name:chararray, address:tuple(city:chararray, pincode:chararray), 
                 result:bag{info:tuple(sub:chararray, marks:int)}, m:map[int]);
                 
1) b) Load sample_student_data.csv for basic operations
<pig terminal>
 student_info = LOAD '/prac_5/sample_student_data.csv' USING PigStorage(',')
               AS (id:int, first_name:chararray, last_name:chararray, age:int, 
                   contact:chararray, city:chararray);

1) c) Display Data:
Use DUMP to check the loaded data:
<pig terminal>
DUMP DataModels;
DUMP student_info;

 --------------------------------------------------------------------- Part 2: Pig Data Types  ----------------------------------------------

Verify Data Types:
Check the schema for both datasets:
<pig terminal>
DESCRIBE DataModels;
DESCRIBE student_info;

 --------------------------------------------------------------------- Part 3: Download Data (from HDFS to Local)  ----------------------------------------------
1) Store Data in HDFS Output Directory:
Store student_info data in an HDFS directory:
<pig terminal>
STORE student_info INTO '/user/cloudera/output/student_info_output' USING PigStorage('|');     ex: STORE student_info INTO '/prac_5/student_info_output' USING PigStorage('|');
STORE DataModels INTO '/user/cloudera/output/DataModels_output' USING PigStorage('|');         ex: STORE DataModels INTO '/prac_5/Data_Models_output/DataModels_output' USING PigStorage('|');

2) Download from HDFS to Local:
After storing data, download it to the local filesystem:(do it in hdfs terminal)
<bash>
hdfs dfs -get /user/cloudera/output/student_info_output /local/path/student_info_output     ex: hdfs dfs -get /prac_5/student_info_output /home/cloudera/prac_5/student_info_output
hdfs dfs -get /user/cloudera/output/student_info_output /local/path/student_info_output     ex:  hdfs dfs -get /prac_5/Data_Models_output/DataModels_output /home/cloudera/prac_5/DataModels_output 

-------------------------------------------------------------------- Part 4: Create Your Script ----------------------------------------------
Write a Pig Script:
Save the following script as student_analysis.pig:
create a new document in prac_5 folder cloudera local and copy paste the below content in that file 
****************** < make necesaary changes to the path mention in student_analysis.pig > ***********************************

-- Load student data
student_info = LOAD '/prac_5/sample_student_data.csv' USING PigStorage(',')
               AS (id:int, first_name:chararray, last_name:chararray, age:int, 
                   contact:chararray, city:chararray);

-- Filter students older than 30
filter_students = FILTER student_info BY age > 30;

-- Group by city
city_group = GROUP student_info BY city;

-- Calculate average age by city
avg_age_by_city = FOREACH city_group GENERATE group AS city, AVG(student_info.age) AS avg_age;

-- Store results
STORE avg_age_by_city INTO '/user/cloudera/output/avg_age_by_city' USING PigStorage(',');

******************************

save the file as < student_analysis.pig > 

-------------------------------------------------------------------- Part 5: Save and Execute the Script ----------------------------------------------
Save and Run the Script:
Save the script as student_analysis.pig and execute it from the command line:
<bash > 
pig -x mapreduce /path/to/student_analysis.pig          ex: pig -x mapreduce /home/cloudera/prac_5/student_analysis.pig

-------------------------------------------------------------------- Part 6: Pig Operations ----------------------------------------------
Diagnostic Operators
Describe Schema:
< pig terminal >
DESCRIBE student_info;

Explain Data Processing:
<pig terminal >
filter_students = FILTER student_info BY age > 30;
EXPLAIN filter_students;

Illustrate Sample Data:
ILLUSTRATE filter_students;

-----------------------------------
Grouping and Joining

1) Group by City:
Group student data by city:
< pig terminal >
city_group = GROUP student_info BY city;

2) Join with Another Dataset (e.g., DataModels):

Join student_info with DataModels if fields align
joined_data = JOIN student_info BY city, DataModels BY address.city;
DUMP joined_data;

-----------------------------------------------------------------------------------

Combining & Splitting

1) Combine Datasets: ( detailed process below ) 
If you have two datasets, use UNION to combine them:
< pig terminal >
combined_data = UNION student_info, some_other_data;


--------------- Part 2: Creating an Additional Dataset for Union Operation------------------ 
1) Sample Data for other_student_data.csv
create a new document in prac_5 folder cloudera local and copy paste the below content in that document and Save this content as other_student_data.csv:

7,Emma,Stone,27,555-1122,San Francisco
8,Chris,Evans,33,555-3344,Houston
9,Scarlett,Johansson,29,555-5566,New York


2) Upload other_student_data.csv to HDFS
< bash> 
[cloudera@quickstart prac_5]$ hdfs dfs -put /home/cloudera/prac_5/other_student_data.csv /prac_5/other_student_data.csv

3) Load and Union the Datasets
Load other_student_data.csv with the same schema as student_info:
< pig terminal > 
other_student_info = LOAD '/user/cloudera/other_student_data.csv' USING PigStorage(',')
                     AS (id:int, first_name:chararray, last_name:chararray, age:int, 
                         contact:chararray, city:chararray);

                         
4) Perform the Union Operation:
Now that student_info and other_student_info have the same schema, you can combine them using UNION:
< pig terminal>
combined_data = UNION student_info, other_student_info;
DUMP combined_data;


2) Split Data:
Split student_info based on age:
< pig terminal >
SPLIT student_info INTO older_than_30 IF age > 30, younger_than_30 IF age <= 30;

-----------------------------------------------------------------------------------------

Filtering and Sorting
1) Filter Students from a Specific City:

nyc_students = FILTER student_info BY city == 'New York';
DUMP nyc_students

2) sort Students by Age:

Sort student_info by age in descending order:
sorted_by_age = ORDER student_info BY age DESC;












