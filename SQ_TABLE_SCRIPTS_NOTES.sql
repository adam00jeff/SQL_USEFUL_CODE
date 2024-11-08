/*-----------------------------------------------------------------------------
Viewing Table Information
------------------------------------------------------------------------------*/
-- The data dictionary stores information about your database. You can query this to see which tables it contains. 
select table_name, iot_name, iot_type, external, 
       partitioned, temporary, cluster_name
from   user_tables;

-- VIEW COLUMN Information
select table_name, column_name, data_type, data_length, data_precision, data_scale
from   user_tab_columns;

/*-----------------------------------------------------------------------------
TABLE MANAGEMENT EXAMPLES
------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------
create table
------------------------------------------------------------------------------*/
CREATE TABLE TASK_INTERVAL_TYPE  (
    id number,
    type varchar(25)
);

/*-----------------------------------------------------------------------------
insert into table
------------------------------------------------------------------------------*/
INSERT INTO [table] (
    [column(s)]
) VALUES (
'[value]'
);

/*-----------------------------------------------------------------------------
truncate table (drop rows keep table)
------------------------------------------------------------------------------*/
 truncate table [table];

/*-----------------------------------------------------------------------------
restet a sqeuence
------------------------------------------------------------------------------*/
alter sequence [seq] restart start with [value];

/*-----------------------------------------------------------------------------
 alter column data type 
------------------------------------------------------------------------------*/
ALTER TABLE [tbl]
  MODIFY( [column] [datatype][precision] );

/*-----------------------------------------------------------------------------
alter column make unique
------------------------------------------------------------------------------*/
ALTER TABLE [tbl] ADD CONSTRAINT [constraint name] [constraint(e.g.unique)](column);

/*-----------------------------------------------------------------------------
rename cols
------------------------------------------------------------------------------*/
--ALTER TABLE [tbl]
--RENAME COLUMN [column] TO [new_name];



/*-----------------------------------------------------------------------------
Add a new column with a column-level constraint to an existing table 
------------------------------------------------------------------------------*/
-- An exception will be thrown if the table contains any rows since the newcol will
-- be initialized to NULL in all existing rows in the table
ALTER TABLE CITIES ADD COLUMN REGION VARCHAR(26)
CONSTRAINT NEW_CONSTRAINT CHECK (REGION IS NOT NULL);

/*-----------------------------------------------------------------------------
Add a new unique constraint to an existing table
------------------------------------------------------------------------------*/
-- An exception will be thrown if duplicate keys are found
ALTER TABLE SAMP.DEPARTMENT
ADD CONSTRAINT NEW_UNIQUE UNIQUE (DEPTNO);

/*-----------------------------------------------------------------------------
Add a new foreign key constraint to the Cities table.
------------------------------------------------------------------------------*/
-- Each row in Cities is checked to make sure it satisfied the constraints.
-- if any rows don't satisfy the constraint, the constraint is not added
ALTER TABLE CITIES ADD CONSTRAINT COUNTRY_FK
Foreign Key (COUNTRY) REFERENCES COUNTRIES (COUNTRY);

/*-----------------------------------------------------------------------------
Add a primary key constraint to a table
------------------------------------------------------------------------------*/
-- First, create a new table
CREATE TABLE ACTIVITIES (CITY_ID INT NOT NULL,
SEASON CHAR(2), ACTIVITY VARCHAR(32) NOT NULL);
-- You will not be able to add this constraint if the columns you are including in the primary key have null data or duplicate values.
ALTER TABLE Activities ADD PRIMARY KEY (city_id, activity);

/*-----------------------------------------------------------------------------
Drop the city_id column if there are no dependent objects:
------------------------------------------------------------------------------*/
ALTER TABLE Cities DROP COLUMN city_id RESTRICT;

/*-----------------------------------------------------------------------------
Drop the city_id column, also dropping all dependent objects:
------------------------------------------------------------------------------*/
ALTER TABLE Cities DROP COLUMN city_id CASCADE;

/*-----------------------------------------------------------------------------
Drop a primary key constraint from the CITIES table
------------------------------------------------------------------------------*/
ALTER TABLE Cities DROP CONSTRAINT Cities_PK;

/*-----------------------------------------------------------------------------
Drop a foreign key constraint from the CITIES table
------------------------------------------------------------------------------*/
ALTER TABLE Cities DROP CONSTRAINT COUNTRIES_FK;

/*-----------------------------------------------------------------------------
add a DEPTNO column with a default value of 1
------------------------------------------------------------------------------*/
ALTER TABLE SAMP.EMP_ACT ADD COLUMN DEPTNO INT DEFAULT 1;

/*-----------------------------------------------------------------------------
increase the width of a VARCHAR column
------------------------------------------------------------------------------*/
ALTER TABLE SAMP.EMP_PHOTO ALTER PHOTO_FORMAT SET DATA TYPE VARCHAR(30);

/*-----------------------------------------------------------------------------
change the lock granularity of a table
------------------------------------------------------------------------------*/
ALTER TABLE SAMP.SALES LOCKSIZE TABLE;

/*-----------------------------------------------------------------------------
Remove the NOT NULL constraint from the MANAGER column
------------------------------------------------------------------------------*/
ALTER TABLE Employees ALTER COLUMN Manager NULL;

/*-----------------------------------------------------------------------------
Add the NOT NULL constraint to the SSN column
------------------------------------------------------------------------------*/
ALTER TABLE Employees ALTER COLUMN ssn NOT NULL;

/*-----------------------------------------------------------------------------
Change the default value for the SALARY column
------------------------------------------------------------------------------*/
ALTER TABLE Employees ALTER COLUMN Salary DEFAULT 1000.0
ALTER TABLE Employees ALTER COLUMN Salary DROP DEFAULT

/*-----------------------------------------------------------------------------
create or replace trigger for primary key 
------------------------------------------------------------------------------*/
create or replace trigger [trigger name]  
  before insert on "[schema]"."[table]" 
  for each row 
begin  
  if inserting then 
     if :NEW."ID" is null then 
        select TASK_TADE_PK_SEQ.nextval into :NEW."ID" from dual; 
     end if; 
  end if; 
end;

/*-----------------------------------------------------------------------------
create or replace trigger for audit cols
------------------------------------------------------------------------------*/
create or replace TRIGGER  TAWF_AUD_COLS_TRG
 BEFORE INSERT OR UPDATE ON  "GIMS"."TASK_WORKFLOW" 
 REFERENCING FOR EACH ROW
 DECLARE
BEGIN
   IF inserting THEN
       :NEW.created_date := SYSDATE;
       :NEW.created_by := nvl(v('APP_USER'),USER);
       :NEW.last_updated_date := SYSDATE;
       :NEW.last_updated_by := nvl(v('APP_USER'),USER);
   elsif updating THEN
       :NEW.last_updated_date := SYSDATE;
       :NEW.last_updated_by := nvl(v('APP_USER'),USER);
   END IF;
  exception
    WHEN others THEN
      system_utilities_pkg.log_error('TRIGGER - accessory_categories_biu - Error: '||sqlerrm);
    raise;
end;

/*-----------------------------------------------------------------------------
Table Clusters
------------------------------------------------------------------------------*/

-- A table cluster can store rows from many tables in the same physical location. To do this, first you must create the cluster:
create cluster toy_cluster (
  toy_name varchar2(100)
);

-- Then place your tables in it using the cluster clause of create table:
create table toys_cluster_tab (
  toy_name varchar2(100)
) cluster toy_cluster ( toy_name );

create table toy_owners_cluster_tab (
  owner    varchar2(20),
  toy_name varchar2(100)
) cluster toy_cluster ( toy_name );

-- You can view details of clusters by querying the *_clusters views
select cluster_name from user_clusters;

select table_name, cluster_name
from   user_tables
where  table_name in ( '/*TBL_NAMES*/' );
