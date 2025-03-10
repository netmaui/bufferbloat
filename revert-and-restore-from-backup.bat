@echo off

:: Ask the user for the backup file name
set /p backupFile=Enter the name of the backup file to restore (with extension): 

:: Check if the user provided a file name
if "%backupFile%"=="" (
    echo No backup file name provided. Exiting...
    exit /b 1
)

:: Check if the backup file exists
if not exist "%backupFile%" (
    echo Backup file "%backupFile%" not found. Exiting...
    exit /b 1
)

:: Restore registry settings
echo Restoring registry settings...
for /f "tokens=*" %%i in ('type %backupFile% ^| findstr /i "HKEY_LOCAL_MACHINE"') do (
    reg add %%i
)

:: Restore PowerShell settings
echo Restoring PowerShell settings...
PowerShell.exe -Command "Get-Content -Path '%backupFile%' | ForEach-Object { if ($_ -notmatch 'HKEY_LOCAL_MACHINE') { Invoke-Expression $_ } }"

:: netsh commands for TCP settings
netsh int tcp set supplemental internet congestionprovider=cubic
pause

echo Restore completed successfully.

exit