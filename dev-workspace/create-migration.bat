@echo off
setlocal enabledelayedexpansion

:: Set working directory to the project root (database folder)
cd /d "%~dp0.."


:: ======================================
:: E-commerce Database Migration Creator
:: Schema-Based Folder Structure
:: ======================================
echo ======================================
echo E-commerce Database Migration Creator
echo Schema-Based Structure
echo ======================================
echo.

:: ======================================
:: STEP 1: Select Schema
:: ======================================
echo Step 1: Select Schema
echo ----------------------
echo   1. Identity    (V0001-V0999)
echo   2. Sales       (V1000-V1999)
echo   3. Inventories (V2000-V2999)
echo.
set /p SCHEMA_CHOICE="Enter choice (1-3): "

if "%SCHEMA_CHOICE%"=="1" (
    set SCHEMA_NAME=identity
    set SCHEMA_DIR=identity
    set STRUCTURE_MIN=0001
    set STRUCTURE_MAX=0499
    set DATA_MIN=0500
    set DATA_MAX=0999
)
if "%SCHEMA_CHOICE%"=="2" (
    set SCHEMA_NAME=sales
    set SCHEMA_DIR=sales
    set STRUCTURE_MIN=1000
    set STRUCTURE_MAX=1499
    set DATA_MIN=1500
    set DATA_MAX=1999
)
if "%SCHEMA_CHOICE%"=="3" (
    set SCHEMA_NAME=inventories
    set SCHEMA_DIR=inventories
    set STRUCTURE_MIN=2000
    set STRUCTURE_MAX=2499
    set DATA_MIN=2500
    set DATA_MAX=2999
)

if "%SCHEMA_NAME%"=="" (
    echo.
    echo ERROR: Invalid choice. Please enter 1, 2, or 3.
    pause
    exit /b 1
)

:: ======================================
:: STEP 2: Select Type
:: ======================================
echo.
echo Step 2: Select Migration Type
echo ------------------------------
echo   1. Structure (Schema changes - Tables, Columns, Indexes)
echo   2. Data (Seed data, Updates)
echo.
set /p TYPE_CHOICE="Enter choice (1-2): "

if "%TYPE_CHOICE%"=="1" (
    set MIGRATION_TYPE=structure
    set VERSION_MIN=%STRUCTURE_MIN%
    set VERSION_MAX=%STRUCTURE_MAX%
)
if "%TYPE_CHOICE%"=="2" (
    set MIGRATION_TYPE=data
    set VERSION_MIN=%DATA_MIN%
    set VERSION_MAX=%DATA_MAX%
)

if "%MIGRATION_TYPE%"=="" (
    echo.
    echo ERROR: Invalid choice. Please enter 1 or 2.
    pause
    exit /b 1
)

:: ======================================
:: STEP 3: Find Next Version
:: ======================================
echo.
echo Step 3: Finding Next Version Number
echo ------------------------------------

set LATEST=0
set SEARCH_DIR=migrations\%SCHEMA_DIR%\%MIGRATION_TYPE%

if not exist "%SEARCH_DIR%" (
    echo Creating directory: %SEARCH_DIR%
    mkdir "%SEARCH_DIR%" 2>nul
)

for %%f in (%SEARCH_DIR%\V*.sql) do (
    set filename=%%~nf
    set "_raw=!filename:~1!"
    for /f "tokens=1 delims=_-" %%v in ("!_raw!") do set "version=%%v"
    2>nul set /a _ver_dec=1!version!-10000
    if errorlevel 1 set /a _ver_dec=0
    if !_ver_dec! GTR !LATEST! set LATEST=!_ver_dec!
)

if !LATEST! EQU 0 (
    set /a NEXT=%VERSION_MIN%
) else (
    if !LATEST! LSS %VERSION_MIN% (
        set /a NEXT=%VERSION_MIN%
    ) else if !LATEST! GEQ %VERSION_MAX% (
        echo WARNING: Approaching max version %VERSION_MAX% for %MIGRATION_TYPE%!
        set /a NEXT=LATEST+1
    ) else (
        set /a NEXT=LATEST+1
    )
)

:: Format version number (4 digits)
set NEXT_VERSION=0000!NEXT!
set NEXT_VERSION=!NEXT_VERSION:~-4!
set FILE_PREFIX=V!NEXT_VERSION!

if !LATEST! EQU 0 (
    echo No migrations found in this folder.
    echo Starting at: V!NEXT_VERSION! ^(range: V%VERSION_MIN%-V%VERSION_MAX%^)
) else (
    echo Latest version : V!LATEST!
    echo Next version   : V!NEXT_VERSION! ^(range: V%VERSION_MIN%-V%VERSION_MAX%^)
)

:: ======================================
:: STEP 4: Get Migration Details
:: ======================================
echo.
echo Step 4: Migration Details
echo -------------------------
set /p TICKET="Ticket number (e.g., EC-101): "
set /p DESCRIPTION="Description (snake_case, e.g., add_avatar_column): "

:: ======================================
:: STEP 5: Create File
:: ======================================
echo.
echo Step 5: Creating Migration File
echo --------------------------------

set FILENAME=%FILE_PREFIX%__%SCHEMA_NAME%_%MIGRATION_TYPE%__%DESCRIPTION%.sql
set FILEPATH=%SEARCH_DIR%\%FILENAME%

:: Get current date
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "DATE=%YYYY%-%MM%-%DD%"

:: Get username
set "AUTHOR=%USERNAME%"

:: ======================================
:: Create Migration File Content
:: ======================================
(
echo -- Ticket: %TICKET%
echo -- Description: %DESCRIPTION%
echo -- Schema: %SCHEMA_NAME%
echo -- Type: %MIGRATION_TYPE%
echo -- Date: %DATE%
echo -- Author: %AUTHOR%
echo.
echo -- =============================================================================
echo -- MIGRATION: %DESCRIPTION%
echo -- =============================================================================
echo -- Purpose: [Detailed explanation of why this change is needed]
echo --
echo -- Impact:
echo --   - Tables affected: %SCHEMA_NAME%.[table_name]
echo --   - Estimated execution time: [X seconds]
echo --   - Backward compatible: [Yes/No]
echo --   - Requires data migration: [Yes/No]
echo --
echo -- Testing:
echo --   - [ ] Tested on local database
echo --   - [ ] Verified with existing data
echo --   - [ ] Application tested
echo --
echo -- Rollback:
echo --   - Method: Create new migration to undo
echo -- =============================================================================
echo.

if "%MIGRATION_TYPE%"=="structure" (
    echo -- =============================================================================
    echo -- STRUCTURE MIGRATION - Schema Changes
    echo -- =============================================================================
    echo.
    echo -- Example: Create Table
    echo -- CREATE TABLE IF NOT EXISTS %SCHEMA_NAME%.table_name ^(
    echo --     "Id" BIGSERIAL PRIMARY KEY,
    echo --     "Name" VARCHAR^(255^) NOT NULL,
    echo --     "Status" VARCHAR^(5^) DEFAULT 'ACT',
    echo --     "CreatedOn" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    echo --     "CreatedBy" VARCHAR^(100^),
    echo --     "ModifiedOn" TIMESTAMP,
    echo --     "ModifiedBy" VARCHAR^(100^)
    echo -- ^);
    echo.
    echo -- Example: Add Column
    echo -- ALTER TABLE %SCHEMA_NAME%.table_name
    echo -- ADD COLUMN IF NOT EXISTS "ColumnName" VARCHAR^(255^);
    echo.
    echo -- Example: Create Index
    echo -- CREATE INDEX IF NOT EXISTS idx_table_column
    echo -- ON %SCHEMA_NAME%.table_name^("ColumnName"^);
    echo.
    echo -- Add your migration SQL here:
    echo.
    echo.
) else (
    echo -- =============================================================================
    echo -- DATA MIGRATION - Seed Data / Updates
    echo -- =============================================================================
    echo.
    echo -- Example: Seed Data
    echo -- INSERT INTO %SCHEMA_NAME%.table_name ^("Id", "Name", "Code", "Status"^)
    echo -- VALUES
    echo --     ^(1, 'Value 1', 'CODE1', 'ACT'^),
    echo --     ^(2, 'Value 2', 'CODE2', 'ACT'^)
    echo -- ON CONFLICT ^("Id"^) DO UPDATE
    echo -- SET
    echo --     "Name" = EXCLUDED."Name",
    echo --     "Code" = EXCLUDED."Code",
    echo --     "Status" = EXCLUDED."Status",
    echo --     "ModifiedOn" = CURRENT_TIMESTAMP,
    echo --     "ModifiedBy" = 'system';
    echo.
    echo -- Add your data migration SQL here:
    echo.
    echo.
)

echo -- =============================================================================
echo -- POST-MIGRATION VALIDATION
echo -- =============================================================================
echo.
echo -- DO $$
echo -- BEGIN
echo --     IF NOT EXISTS ^(
echo --         SELECT 1 FROM information_schema.columns
echo --         WHERE table_schema = '%SCHEMA_NAME%'
echo --         AND table_name = 'table_name'
echo --         AND column_name = 'ColumnName'
echo --     ^) THEN
echo --         RAISE EXCEPTION 'Migration failed: Column not created';
echo --     END IF;
echo --
echo --     RAISE NOTICE 'Migration completed successfully';
echo -- END $$;
echo.

) > "%FILEPATH%"

:: ======================================
:: Summary
:: ======================================
echo.
echo ======================================
echo Migration Created Successfully!
echo ======================================
echo.
echo File Details:
echo   Name   : %FILENAME%
echo   Path   : %FILEPATH%
echo   Type   : %MIGRATION_TYPE% ^(%FILE_PREFIX%^)
echo   Schema : %SCHEMA_NAME%
echo.
echo Folder Structure:
echo   migrations/
echo     %SCHEMA_DIR%/
echo       %MIGRATION_TYPE%/
echo         %FILENAME%
echo.
echo Next Steps:
echo   1. Edit the file and add your SQL
echo   2. Migrate : flyway migrate
echo   3. Verify  : flyway info
echo   4. Commit  : git add %FILEPATH%
echo   5. Push your changes
echo.
echo Opening file in notepad...
echo.

:: Open the file in notepad
start notepad "%FILEPATH%"

echo.
echo Press any key to exit...
pause >nul