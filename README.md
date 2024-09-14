# SQL Utility Stored Procedures

This repository contains a collection of utility stored procedures to help manage and interact with SQL Server databases more efficiently.

## Stored Procedures

### 1. **[dbo].[GenerateInsertScript]**

The `GenerateInsertScript` stored procedure generates `INSERT` scripts for the entire dataset of a specified table. This is useful when you want to replicate data from one table or environment to another.

#### Usage:

```sql
EXEC [dbo].[GenerateInsertScript] @FullTableName = 'SchemaName.TableName'
