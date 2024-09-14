# SQL Utility Stored Procedures

This repository contains a collection of utility stored procedures to help manage and interact with SQL Server databases more efficiently.

## Stored Procedures

### 1. **GenerateInsertScript**

The `GenerateInsertScript` stored procedure generates `INSERT` scripts for the entire dataset of a specified table. This is useful when you want to replicate data from one table or environment to another.

#### Usage:

```sql
EXEC [dbo].[GenerateInsertScript] @FullTableName = 'SchemaName.TableName'

### Important Note: Handling Identity Columns

If the table you're generating the `INSERT` script for contains an **Identity** column, you must temporarily enable **Identity Insert** to allow the insertion of specific identity values.

The `GenerateInsertScript` procedure automatically handles this by generating the script with the necessary `SET IDENTITY_INSERT` statements. However, when you execute the generated script, you need to be aware of the following:

- **Identity Insert** allows inserting explicit values into identity columns.
- The generated script will include the following lines to turn **Identity Insert** on and off:

```sql
SET IDENTITY_INSERT [SchemaName].[TableName] ON

-- Insert statements

SET IDENTITY_INSERT [SchemaName].[TableName] OFF
