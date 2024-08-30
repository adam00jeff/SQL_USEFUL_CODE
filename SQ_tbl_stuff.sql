-- TABLE MANAGEMENT 

-- Viewing Table Information
-- The data dictionary stores information about your database. You can query this to see which tables it contains. 
select table_name, iot_name, iot_type, external, 
       partitioned, temporary, cluster_name
from   user_tables;

-- VIEW COLUMN Information
select table_name, column_name, data_type, data_length, data_precision, data_scale
from   user_tab_columns;


-- Table Clusters
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


/*-----------------------------------------------------------------------------
create table
------------------------------------------------------------------------------*/
--CREATE TABLE TASK_INTERVAL_TYPE  (
--    id number,
--    type varchar(25)
--);

/*-----------------------------------------------------------------------------
insert into table
------------------------------------------------------------------------------*/
--INSERT INTO [table] (
--    [column(s)]
--) VALUES (
--'[value]'
--);

/*-----------------------------------------------------------------------------
truncate table (drop rows keep table)
------------------------------------------------------------------------------*/
-- truncate table [table];

/*-----------------------------------------------------------------------------
--restet a sqeuence
------------------------------------------------------------------------------*/
--alter sequence [seq] restart start with [value];

/*-----------------------------------------------------------------------------
-- alter column data type 
------------------------------------------------------------------------------*/
--ALTER TABLE [tbl]
--  MODIFY( [column] [datatype][precision] );

/*-----------------------------------------------------------------------------
--alter column make unique
------------------------------------------------------------------------------*/
--ALTER TABLE [tbl] ADD CONSTRAINT [constraint name] [constraint(e.g.unique)](column);

/*-----------------------------------------------------------------------------
-- rename cols
------------------------------------------------------------------------------*/
--ALTER TABLE [tbl]
--RENAME COLUMN [column] TO [new_name];

/*-----------------------------------------------------------------------------
create or replace trigger for primary key 
------------------------------------------------------------------------------*/
--create or replace trigger [trigger name]  
--   before insert on "[schema]"."[table]" 
--   for each row 
--begin  
--   if inserting then 
--      if :NEW."ID" is null then 
--         select TASK_TADE_PK_SEQ.nextval into :NEW."ID" from dual; 
--      end if; 
--   end if; 
--end;

/*-----------------------------------------------------------------------------
create or replace trigger for audit cols
------------------------------------------------------------------------------*/
--create or replace TRIGGER  TAWF_AUD_COLS_TRG
--  BEFORE INSERT OR UPDATE ON  "GIMS"."TASK_WORKFLOW" 
--  REFERENCING FOR EACH ROW
--  DECLARE
--BEGIN
--    IF inserting THEN
--        :NEW.created_date := SYSDATE;
--        :NEW.created_by := nvl(v('APP_USER'),USER);
--        :NEW.last_updated_date := SYSDATE;
--        :NEW.last_updated_by := nvl(v('APP_USER'),USER);
--    elsif updating THEN
--        :NEW.last_updated_date := SYSDATE;
--        :NEW.last_updated_by := nvl(v('APP_USER'),USER);
--    END IF;
--   exception
--     WHEN others THEN
--       system_utilities_pkg.log_error('TRIGGER - accessory_categories_biu - Error: '||sqlerrm);
--     raise;
--end;

