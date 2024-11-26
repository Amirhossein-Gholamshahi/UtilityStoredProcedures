# SQL Utility Stored Procedures

This repository contains a collection of utility stored procedures to help manage and interact with SQL Server databases more efficiently.

## Stored Procedures

# 1. **GenerateInsertScript**

The `GenerateInsertScript` stored procedure generates `INSERT` scripts for the entire dataset of a specified table. This is useful when you want to replicate data from one table or environment to another.

#### Usage:

```sql
EXEC [dbo].[GenerateInsertScript] @FullTableName = 'SchemaName.TableName'
```
### Important Note: Handling Identity Columns

If the table you're generating the `INSERT` script for contains an **Identity** column, you must temporarily enable **Identity Insert** to allow the insertion of specific identity values.

The `GenerateInsertScript` procedure automatically handles this by generating the script with the necessary `SET IDENTITY_INSERT` statements. However, when you execute the generated script, you need to be aware of the following:

- **Identity Insert** allows inserting explicit values into identity columns.
- The generated script will include the following lines to turn **Identity Insert** on and off:

```sql
SET IDENTITY_INSERT [SchemaName].[TableName] ON

-- Insert statements

SET IDENTITY_INSERT [SchemaName].[TableName] OFF
```

# 2.FindKeyWordInTable Stored Procedure

## Overview
The `FindKeyWordInTable` stored procedure allows you to search for a specified keyword across all columns of a given table in a SQL Server database. This procedure returns the first row where the keyword is found, or indicates if no results are found.

## Parameters
- `@KeyWord NVARCHAR(MAX)`: The keyword to search for within the table.
- `@FullTableName VARCHAR(max)`: The full name of the table in the format `SchemaName.TableName`.

## Usage
To execute the stored procedure, use the following SQL command:

```sql
EXEC [dbo].[FindKeyWordInTable] @KeyWord = 'your_keyword', @FullTableName = 'your_schema.your_table';
```

# 3. **FindById Stored Procedure**

## Overview
The `FindById` stored procedure retrieves a row from a specified table in a SQL Server database based on the primary key value. This procedure dynamically identifies the primary key column of the target table, formats the input value based on the primary key's data type, and returns the corresponding row if found.

## Parameters
- `@FullTableName VARCHAR(MAX)`: The full name of the table in the format `SchemaName.TableName`.
- `@id NVARCHAR(MAX)`: The primary key value to search for within the specified table.

## Usage
To execute the stored procedure, use the following SQL command:

```sql
EXEC [dbo].[FindById] @FullTableName = 'your_schema.your_table', @id = 'your_primary_key_value';
