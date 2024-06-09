@echo on

:: Check for administrative rights
NET SESSION >nul 2>&1
if %errorLevel% == 0 (
    echo Running as Administrator...
) else (
    echo This script requires administrative privileges to run.
    pause
    exit /B
)

:: Delete vgc and vgk services
echo Deleting service vgc...
sc delete vgc

echo Deleting service vgk...
sc delete vgk

:: Ask user whether to restart the PC
set /p restartNow=Do you want to restart your computer now? (y/n): 
if /i "%restartNow%"=="y" (
    shutdown /r /f /t 0
) else (
    echo Services removed. Please restart your computer later to apply changes.
    pause
    exit /B
)
