
CREATE OR ALTER PROCEDURE [dbo].[FindKeyWordInTable] @KeyWord NVARCHAR(MAX), @FullTableName VARCHAR(max)
AS
DECLARE @query AS VARCHAR(max);
DECLARE @SchemaName VARCHAR(50) = PARSENAME(@FullTableName, 2) 
DECLARE @TableName VARCHAR(50) = PARSENAME(@FullTableName, 1)
SET NOCOUNT ON
DECLARE @TableDataQuery VARCHAR(MAX) = 'SELECT ROW_NUMBER() OVER (ORDER BY ';
SET @query = 'SELECT ORDINAL_POSITION
	,COLUMN_NAME
	,IS_NULLABLE
	,DATA_TYPE
	INTO ##TableInfo
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = '
SET @query += '''' + @TableName + ''''
SET @query += ' AND TABLE_SCHEMA = '
SET @query += '''' + @SchemaName + ''''
EXEC (@query)

SET @TableDataQuery += (SELECT COLUMN_NAME FROM ##TableInfo WHERE ORDINAL_POSITION = 1)
SET @TableDataQuery += ') AS j,* INTO ##TableData FROM ' + @FullTableName;
EXEC (@TableDataQuery);

DECLARE @j int = 1;
WHILE @j <= (SELECT COUNT(*) FROM ##TableData)
BEGIN
	DECLARE @k int = 1;
	WHILE @k <= (SELECT COUNT(*) FROM ##TableInfo)
		BEGIN
			DECLARE @ValueOut AS NVARCHAR(MAX);
			DECLARE @FormattedValue NVARCHAR(MAX)
			DECLARE @ValueQuery AS NVARCHAR(MAX) = 'SET @ValueOut = (SELECT CAST(' + (SELECT COLUMN_NAME FROM ##TableInfo WHERE ORDINAL_POSITION = @k) + ' AS NVARCHAR) FROM ##TableData WHERE j = ' + CAST(@j AS VARCHAR) + ')';
			EXEC SP_EXECUTESQL @ValueQuery, N'@ValueOut NVARCHAR(MAX) OUTPUT', @ValueOut OUTPUT 
			IF @ValueOut LIKE '%' + @KeyWord + '%' 
				BEGIN
					SELECT * INTO ##Result FROM ##TableData WHERE j = @j 
					ALTER TABLE ##Result 
					DROP COLUMN j
					SELECT * FROM ##Result
					DROP TABLE ##TableInfo
					DROP TABLE ##TableData
					DROP TABLE ##Result
					RETURN 0;
				END 
			SET @k = @k + 1
			END
		SET @j = @j + 1
		END
SELECT 'No Result Found!' AS RESULT
DROP TABLE ##TableInfo
DROP TABLE ##TableData