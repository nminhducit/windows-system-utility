@echo off
title Windows System Administration Menu - NMINHDUCIT
setlocal enabledelayedexpansion
mode con: cols=65 lines=25
color f0

:menu
cls
echo ===============================================================
echo         WINDOWS SYSTEM ADMINISTRATION MENU - NMINHDUCIT
echo ===============================================================
echo 1. Display System Information
echo 2. Clean Temporary Files
echo 3. Check Network Connectivity
echo 4. Manage Processes
echo 5. Manage Services
echo 6. Backup Documents
echo 7. System Event Logs
echo 8. System Diagnostics
echo 9. Reboot Computer
echo 10. Exit
echo ===============================================================
set /p choice=Enter your choice (1-10): 

if "%choice%"=="1" goto system_info
if "%choice%"=="2" goto clean_temp
if "%choice%"=="3" goto check_network
if "%choice%"=="4" goto manage_processes
if "%choice%"=="5" goto manage_services
if "%choice%"=="6" goto backup_documents
if "%choice%"=="7" goto system_logs
if "%choice%"=="8" goto system_diagnostics
if "%choice%"=="9" goto reboot_system
if "%choice%"=="10" goto end

echo Invalid choice. Please enter a number from 1 to 10.
pause
goto menu

:system_info
cls
echo ====== System Information ======
systeminfo | more
pause
goto menu

:clean_temp
cls
echo ====== Cleaning Temporary Files ======
del /Q /F /S %TEMP%\*.*
if %errorlevel% equ 0 (
    echo Temporary files cleaned up successfully.
) else (
    echo Failed to clean temporary files.
)
pause
goto menu

:check_network
cls
echo ====== Checking Network Connectivity ======
ping google.com
pause
goto menu

:manage_processes
cls
echo ====== Manage Processes ======
echo 1. List processes
echo 2. End process
echo 3. Back to main menu
set /p proc_choice=Enter your choice (1-3): 
if "%proc_choice%"=="1" goto list_processes
if "%proc_choice%"=="2" goto stop_process
if "%proc_choice%"=="3" goto menu

echo Invalid choice. Please enter a number from 1 to 3.
pause
goto manage_processes

:list_processes
cls
echo ====== List Processes ======
tasklist | more
pause
goto manage_processes

:stop_process
cls
echo ====== End Process ======
set /p procname=Enter process name (e.g., notepad.exe): 
taskkill /F /IM %procname%
if %errorlevel% equ 0 (
    echo Process %procname% terminated successfully.
) else (
    echo Failed to terminate process %procname%.
)
pause
goto manage_processes

:manage_services
cls
echo ====== Manage Services ======
echo 1. Start service
echo 2. Stop service
echo 3. Back to main menu
set /p serv_choice=Enter your choice (1-3): 
if "%serv_choice%"=="1" goto start_service
if "%serv_choice%"=="2" goto stop_service
if "%serv_choice%"=="3" goto menu

echo Invalid choice. Please enter a number from 1 to 3.
pause
goto manage_services

:start_service
cls
echo ====== Start Service ======
set /p servicename=Enter service name: 
net start %servicename%
if %errorlevel% equ 0 (
    echo Service %servicename% started successfully.
) else (
    echo Failed to start service %servicename%.
)
pause
goto manage_services

:stop_service
cls
echo ====== Stop Service ======
set /p servicename=Enter service name: 
net stop %servicename%
if %errorlevel% equ 0 (
    echo Service %servicename% stopped successfully.
) else (
    echo Failed to stop service %servicename%.
)
pause
goto manage_services

:backup_documents
cls
echo ====== Backup Documents ======
set "src=%userprofile%\Documents"
set "dest=%userprofile%\Backup\Documents"
set "timestamp=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
mkdir "%dest%\%timestamp%" > nul 2>&1
xcopy "%src%" "%dest%\%timestamp%" /E /I /H /Y > nul 2>&1
if %errorlevel% equ 0 (
    echo Documents backed up to %dest%\%timestamp% successfully.
) else (
    echo Failed to backup documents.
)
pause
goto menu

:system_logs
cls
echo ====== System Event Logs ======
eventvwr
pause
goto menu

:system_diagnostics
cls
echo ====== System Diagnostics ======
msinfo32
pause
goto menu

:reboot_system
cls
echo ====== Reboot Computer ======
echo Computer will reboot in 5 seconds...
shutdown /r /t 5
goto menu

:end
endlocal
exit
