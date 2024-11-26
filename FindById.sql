CREATE OR ALTER PROCEDURE [dbo].[FindById] @FullTableName VARCHAR(max), @id NVARCHAR(MAX)
AS
DECLARE @DataType NVARCHAR(128) 
DECLARE @FormattedId NVARCHAR(MAX)
DECLARE @SchemaName NVARCHAR(50) = PARSENAME(@FullTableName, 2) 
DECLARE @TableName NVARCHAR(50) =  PARSENAME(@FullTableName, 1)
DECLARE @query AS NVARCHAR(max) = 'SELECT * FROM ' + @SchemaName + '.' + @TableName;
DECLARE @PkColumn NVARCHAR(128);
SET NOCOUNT ON

SELECT 
    @PkColumn = KU.COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
    JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
    ON TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
WHERE 
    TC.TABLE_NAME = @TableName
	AND TC.TABLE_SCHEMA = @SchemaName
    AND TC.CONSTRAINT_TYPE = 'PRIMARY KEY';

SELECT 
        @DataType = DATA_TYPE
    FROM 
        INFORMATION_SCHEMA.COLUMNS
    WHERE 
        TABLE_NAME = @TableName
        AND TABLE_SCHEMA = @SchemaName
        AND COLUMN_NAME = @PkColumn;

IF @DataType IN ('varchar', 'char', 'text')
    SET @FormattedId = '''' + @id + '''';
ELSE IF @DataType IN ('nvarchar', 'nchar', 'ntext')
    SET @FormattedId = 'N''' + @id + '''';
ELSE IF @DataType IN ('int', 'bigint', 'smallint', 'tinyint', 'decimal', 'numeric', 'float', 'real')
    SET @FormattedId = @id;
ELSE
    SET @FormattedId = @id; 

SET @query = @query + ' WHERE ' + @PkColumn + ' = ' + @formattedId

EXEC sp_executesql @query


