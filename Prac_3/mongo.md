Here’s a guide to perform the CRUD operations, querying, and indexing tasks in MongoDB Compass, which is MongoDB’s official desktop GUI application. This will cover:

1) Setting up a Sample Database and Collection in MongoDB Compass.
2) Inserting, Querying, Updating, and Deleting Documents.
3) Creating and Using Indexes.

Prerequisites
~MongoDB Compass: Ensure MongoDB Compass is installed and connected to your MongoDB instance.


Step-by-Step Guide
----------------------- Part 1: Setting Up the Sample Database and Collection ------------------
1) Open MongoDB Compass and connect to your MongoDB server.
2) Create a New Database:

~ In the main MongoDB Compass interface, click on the "Create Database" button.
~ Database Name: sampleDB
~ Collection Name: students
~ Click Create Database.


------------------------ Part 2: Implement CRUD Operations --------------------------------------

A) Insert Document (Create)
1) Insert a Single Document:

~ In the students collection, click on Insert Document.
~ Add a document in the following format and click Insert:
json
{
  "name": "John Doe",
  "age": 21,
  "course": "Computer Science",
  "grades": { "midterm": 85, "final": 90 },
  "enrolled": true
}

2) Insert Multiple Documents:
~ Click on Insert Document again to insert more records, or use the "Import Data" button for bulk inserts.
~ For multiple documents, insert the following records:
json
{
  "name": "Jane Smith",
  "age": 22,
  "course": "Mathematics",
  "grades": { "midterm": 78, "final": 88 },
  "enrolled": true
},
{
  "name": "Alex Brown",
  "age": 20,
  "course": "Physics",
  "grades": { "midterm": 92, "final": 85 },
  "enrolled": false
},
{
  "name": "Emily Clark",
  "age": 23,
  "course": "Biology",
  "grades": { "midterm": 89, "final": 91 },
  "enrolled": true
}


B) Query Document (Read)
1) Query All Documents:
~ In the students collection, click on the "Find" tab.
~ Leave the query field blank and click Find to retrieve all documents.

2) Query with Conditions:
~ Enrolled Students: Find students who are currently enrolled:
json
{ "enrolled": true }

~ Age Greater Than 21: Find students older than 21:
json
{ "age": { "$gt": 21 } }

3) Project Specific Fields:
~ Retrieve only the name and course fields:
json
{ }, { "name": 1, "course": 1, "_id": 0 }

~ Enter the above in Filter and Project fields respectively, then click Find.

4) Nested Field Query:
~ Find students with a midterm grade above 85:
json
{ "grades.midterm": { "$gt": 85 } }


5) Sort and Limit Results:
~ Sort by final grades in descending order and limit results to the top 2:
~ Filter: { }
~ Sort: { "grades.final": -1 }
~ Limit: 2


------------------------------- C) Update Document (Update) ------------------------------------
1) Update a Single Document:
~ Update Course for John Doe: Find John Doe’s document using { "name": "John Doe" } in the filter, then click on Update.
~ Set course to "Data Science" using the following update document and click Update:
json
{ "$set": { "course": "Data Science" } }


2) Update Multiple Documents:
~ Enroll All Unenrolled Students: In the Find tab, use { "enrolled": false } to filter. Then click Update and enter the following to set enrolled to true:
json
{ "$set": { "enrolled": true } }


3) Increment a Field Value:
~ Increase Age by 1 for All Students: In the Find tab, leave the filter empty, click Update, and enter:
json
{ "$inc": { "age": 1 } }

------------------------------------- D) Delete Document (Delete) ------------------------------------

1) Delete a Single Document:
~ Delete Student Alex Brown: Find Alex’s document by setting { "name": "Alex Brown" } in the Find tab, then click Delete.

2) Delete Multiple Documents:
~ Delete Students in the Biology Course: Filter by { "course": "Biology" } and click Delete to remove all students in that course.


---------------------------------------- Part 3: Indexing in MongoDB --------------------------------------------

Indexes improve query performance by reducing the amount of data MongoDB must scan. In MongoDB Compass, you can easily create and manage indexes.

A) Create Index

1) Create an Index on the name Field:
~ In the Indexes tab, click Create Index.
~ Set the Field to name, Order to Ascending, and click Create Index.

2) Create a Compound Index on age and course:
~ Go to the Indexes tab, click Create Index.
~ Add Fields as follows:
~ age: Ascending
~ course: Ascending
~ Click Create Index.


3) Create a Text Index on the course Field:
~ Go to the Indexes tab and click Create Index.
~ Set the Field to course and change the Type to Text.
~ Click Create Index.


B) Query with Index
1) Using Indexed Fields:
~ Run queries using indexed fields (e.g., name or course) to leverage the index:
json
{ "name": "John Doe" }

2) Verify Index Usage:
~ MongoDB Compass automatically uses indexes for queries on indexed fields.

C) List and Drop Indexes
1) View All Indexes:
~ In the Indexes tab, you can see all indexes created on the students collection.

2)Drop an Index:
~ Click on the Delete icon next to an index to drop it.


--------------------------------------------- NOTE --------------------------------------------

In MongoDB Compass, there is no direct "Update" button in the document view. Instead, you can edit a document by following these steps:

--------------------------------------- Steps to Update a Document in MongoDB Compass -------------------------

1) Open MongoDB Compass and navigate to your sampleDB database and students collection.

2) Find John Doe’s Document:
~ In the Find tab, enter the filter { "name": "John Doe" } and click Find.
~  This will display the document for "John Doe".

3) Edit the Document:
~ Hover over the document to see the Pencil (Edit) icon next to the document.
~ Click the Pencil (Edit) icon to open the document editor.


4) Update the course Field:
~ In the editor, locate the course field and change its value from "Computer Science" to "Data Science".
~ After making the change, click Update at the bottom of the editor to save the document.


5) Verify the Update:
~ Run the query { "name": "John Doe" } again to confirm that the course field is now set to "Data Science".
