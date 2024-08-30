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

