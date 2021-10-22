-- We select sql query to run concatenating table name and table constraint to delete
SELECT 'ALTER TABLE ' + Quotename(ss.NAME) + '.'
       + Quotename(st.NAME) + ' DROP CONSTRAINT'
       + Quotename(so.NAME)
-- We join sys tables, schemas and objects tables to collect all useful data we want to manipulate
FROM   sys.tables st
       INNER JOIN sys.schemas ss
               ON st.[schema_id] = ss.[schema_id]
       INNER JOIN sys.objects so
               ON st.schema_id = so.schema_id
WHERE  st.is_ms_shipped = 0
       AND so.type_desc LIKE '%CONSTRAINT'          -- We must extract from sys objects tables only constraints
       AND so.NAME LIKE '%yourConstraintNameValue%' -- We must extract from sys objects tables only constraints containing a specific value in their name
       AND st.object_id = so.parent_object_id       -- Retrieved constraint must be deleted only for table in which it exists and not for all database tables
       -- AND st.name = "yourTableName"             --> Uncomment this row if you want to delete constraint only for a specific table  
      
