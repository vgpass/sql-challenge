# sql-challenge
This is the repository for the Module 9 SQL Challenge

UCI Data Analytics Bootcamp - Due on Wednesday December 14, 2022

Vincent Passanisi

---

## **Description**

This repository contains the required files for the SQL Challenge

## **Files**

* *README.md* Repo description, list of files, results, and comments and thoughts on the challenge.

* *EmployeeSQL* folder - contains all challenge files

    * employee_db.sql - SQL script for table creation, data import, and required queries.

    * employee_db_ERD.png - Image file of the Entity Relationship Diagram

    * employee_db_ERD.pdf - PDF document describing the ERD

    * *data* - folder containing data .csv starter files  

## **Results**

Completed ERD shows primary keys assigned to each table. Two of the tables have composite keys. Foreign keys assigned to establish correct relationships between tables.

![Image of completed ERD]](EmployeeSQL/employee-db_ERD.png)

First query lists the employee number, last name, first name, sex, and salary of each employee. 

[First Query](EmployeeSQL/data-1671061991265.csv)

## **Comments and Thoughts**

The most difficult part of this challenge for me was setting up the tables and getting the keys right. I had trouble importing the data after the foreign keys were created, so I ended up creating the tables first with the primary keys, importing the data, then modifying the tables to create the foreign keys. In this order, I was able to get all the data imported and the table created with both their primary keys and foreign keys without any errors.

The queries seemed pretty straight-forward. I anticipated having to create some subqueries, but ended up being able to get the results just by using some simple joins.

