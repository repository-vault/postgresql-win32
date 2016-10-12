@echo off
SET HERE=%~dp0
SET PGBIN=%HERE%\bin
SET PGDATABASE=postgres
SET PGPORT=5432
SET PGUSER=postgres
SET PGDATA=%HERE%\data
SET PGLOG=%PGDATA%\log.txt

SET PGLOCALEDIR=%HERE%\share
SET PATH=%PATH%;%PGBIN%


title PostgreSQL Portable
cls

:: set default code page
chcp 1252 > nul

:: initialise a new database on first use
if not exist "%PGDATA%" (
    echo.
    echo Initialising database for first use, please wait...
    "%PGBIN%\initdb" -U %PGUSER% -A trust -E utf8 --locale=C >nul
)

:: startup postgres server
echo.
"%PGBIN%\pg_ctl" -D "%PGDATA%" -l "%PGLOG%" -w start
cls
echo.
echo Type \q to quit and shutdown server
echo.
"%PGBIN%\psql.exe"
echo.
"%PGBIN%\pg_ctl" -D "%PGDATA%" stop
