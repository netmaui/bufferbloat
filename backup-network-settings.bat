@echo off

:: Ask the user for the backup file name
set /p backupFile=Enter the name of the backup file (with extension): 

:: Check if the user provided a file name
if "%backupFile%"=="" (
    echo No backup file name provided. Exiting...
    exit /b 1
)

:: Backup existing registry settings
echo Backing up existing registry settings...
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" >> %backupFile%
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" >> %backupFile%
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" >> %backupFile%
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" >> %backupFile%
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" >> %backupFile%
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" >> %backupFile%
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" >> %backupFile%
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" >> %backupFile%
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" >> %backupFile%

:: Backup existing PowerShell settings
echo Backing up existing PowerShell settings...
PowerShell.exe -Command "Get-NetTCPSetting -SettingName internet | Out-File -FilePath '%backupFile%' -Append -Encoding ASCII"
PowerShell.exe -Command "Get-NetOffloadGlobalSetting | Out-File -FilePath '%backupFile%' -Append -Encoding ASCII"
PowerShell.exe -Command "Get-NetAdapterAdvancedProperty -Name * | Out-File -FilePath '%backupFile%' -Append -Encoding ASCII"

echo Backup completed successfully.

exit