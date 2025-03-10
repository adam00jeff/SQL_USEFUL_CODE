Controlling PL/SQL Warning Messages
To let the database issue warning messages during PL/SQL compilation, you set the initialization parameter PLSQL_WARNINGS. You can enable and disable entire categories of warnings (ALL, SEVERE, INFORMATIONAL, PERFORMANCE), enable and disable specific message numbers, and make the database treat certain warnings as compilation errors so that those conditions must be corrected.

This parameter can be set at the system level or the session level. You can also set it for a single compilation by including it as part of the ALTER PROCEDURE statement. You might turn on all warnings during development, turn off all warnings when deploying for production, or turn on some warnings when working on a particular subprogram where you are concerned with some aspect, such as unnecessary code or performance.

ALTER SYSTEM SET PLSQL_WARNINGS='ENABLE:ALL'; -- For debugging during development.
ALTER SESSION SET PLSQL_WARNINGS='ENABLE:PERFORMANCE'; -- To focus on one aspect.
ALTER PROCEDURE hello COMPILE PLSQL_WARNINGS='ENABLE:PERFORMANCE'; -- Recompile with extra checking.
ALTER SESSION SET PLSQL_WARNINGS='DISABLE:ALL'; -- To turn off all warnings.
-- We want to hear about 'severe' warnings, don't want to hear about 'performance'
-- warnings, and want PLW-06002 warnings to produce errors that halt compilation.
ALTER SESSION SET PLSQL_WARNINGS='ENABLE:SEVERE','DISABLE:PERFORMANCE','ERROR:06002';
