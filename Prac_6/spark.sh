create a folder named Prac_6 in cloudera local 

--------------------------------------------------- Part 1: Downloading a Dataset and Processing It in Spark (with SparkContext) --------------------------------------------------


1) Download Dataset:
~ Download the dataset as before, or use an existing text file:
< bash >
wget https://www.gutenberg.org/files/1342/1342-0.txt -O pride_and_prejudice.txt


2) Upload to HDFS (if required):
< bash >
hdfs dfs -put pride_and_prejudice.txt /user/cloudera/pride_and_prejudice.txt

3) Start spark-shell with SparkContext:
Start the Spark shell to get an instance of SparkContext.
< bash >
spark-shell

4) Initialize SparkContext and Load Data:
~ You’ll typically have sc (an instance of SparkContext) available by default in spark-shell.
~ Load data from a local file or HDFS:
< spark terminal >
// From Local File System
val textFile = sc.textFile("file:///path/to/pride_and_prejudice.txt")

// From HDFS
val textFile = sc.textFile("hdfs:///user/cloudera/pride_and_prejudice.txt")

5) Display First Few Lines:
~ Verify data loading by displaying the first few lines:
< spark terminal >
textFile.take(5).foreach(println)


6) Basic Data Processing in Spark:
~ Count Total Lines:
< spark terminal >
val lineCount = textFile.count()
println(s"Total number of lines: $lineCount")


~ Filter for Specific Words:
< spark terminal >
val elizabethLines = textFile.filter(line => line.contains("Elizabeth"))
elizabethLines.take(5).foreach(println)


--------------------------------------------------- Part 2: Word Count in Apache Spark (with SparkContext) ----------------------------------------------------


1) Load the Dataset Using SparkContext:
~ Load the text file again if needed:
< spark terminal >
val textFile = sc.textFile("hdfs:///user/cloudera/pride_and_prejudice.txt")


2) Perform Word Count:
~ Split each line into words, map each word to a count of 1, and then reduce by key (word) to get the total count for each word.
< spark terminal >
// Split lines, clean up words, and count occurrences
val wordCounts = textFile.flatMap(line => line.split("\\s+"))       // Split by whitespace
                         .map(word => (word.toLowerCase.replaceAll("[^a-zA-Z]", ""), 1))  // Clean words
                         .filter(_._1.nonEmpty)                    // Remove empty strings
                         .reduceByKey(_ + _)                       // Sum counts for each word


3) Display Top 10 Most Common Words:
~ Sort results by count in descending order and display the top 10 words:
< spark terminal >
val topWords = wordCounts.sortBy(_._2, ascending = false)
topWords.take(10).foreach(println)


4) Save Results to HDFS (Optional):
~ Save the word count results to an HDFS directory:
< spark terminal >
wordCounts.saveAsTextFile("hdfs:///user/cloudera/word_count_output")


5) Verify Results (if saved to HDFS):
~ To verify the results saved in HDFS, use the following command:
< bash >
hdfs dfs -ls /user/cloudera/word_count_output
hdfs dfs -cat /user/cloudera/word_count_output/part-00000


---------------------------------------------------------------- Summary of Key Commands -----------------------------------------------------------------------------------------------------------

1) Download and Upload Dataset:
< bash >
wget https://www.gutenberg.org/files/1342/1342-0.txt -O pride_and_prejudice.txt
hdfs dfs -put pride_and_prejudice.txt /user/cloudera/pride_and_prejudice.txt


2) Load Data and Perform Word Count:
< spark terminal >
val textFile = sc.textFile("hdfs:///user/cloudera/pride_and_prejudice.txt")
val wordCounts = textFile.flatMap(line => line.split("\\s+"))
                         .map(word => (word.toLowerCase.replaceAll("[^a-zA-Z]", ""), 1))
                         .filter(_._1.nonEmpty)
                         .reduceByKey(_ + _)
wordCounts.take(10).foreach(println)


3) Sort and Display Top Results:
< spark terminal >
val topWords = wordCounts.sortBy(_._2, ascending = false)
topWords.take(10).foreach(println)

