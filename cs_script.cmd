@echo off
setlocal EnableDelayedExpansion

:: Check if the script is running with administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    :: The script is not running as admin, restart with elevation
    echo Requesting administrative privileges...
    set "batchPath=%~f0"
    :: Start a new Command Prompt with elevated privileges
    powershell -Command "Start-Process cmd -ArgumentList '/c \"%batchPath%\"' -Verb RunAs"
	echo Script is running with administrative privileges.
    goto menu
)
goto menu

::============================================================================
::
::   cs Script v1.3 (catsmoker)
::
::   Homepages: https://github.com/catsmoker/cs_script.bat
::   
::
::   Please Check my website: https://catsmoker.github.io
::
::
::       Email: boulhada08@gmail.com
::
::============================================================================

:menu
cls
echo                                               cs Script v1.2 (by catsmoker) https://catsmoker.github.io
echo                                                                run as administrator
echo Select an option:
echo 1. Scan and Fix Windows
echo 2. Download Specific Applications
echo 3. Activate Windows
echo 4. Download Atlas OS Playbook and AME Wizard
echo 5. Exit

powershell -Command "$null = New-Item -Path ([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'CS Downloads')) -ItemType Directory -ErrorAction SilentlyContinue"

set /p choice=Enter your choice (1-5): 

if "%choice%"=="1" goto scan_fix_windows
if "%choice%"=="2" goto download_apps
if "%choice%"=="3" goto activate_windows
if "%choice%"=="4" goto ame_playbook
if "%choice%"=="5" goto exit_script
echo Invalid choice. Please enter a number between 1 and 5.
goto menu

:scan_fix_windows
cls
echo Scanning and fixing Windows...
sfc /scannow
if %errorlevel% neq 0 (
    echo sfc encountered an issue.
    pause
    goto menu
)
echo Running DISM RestoreHealth...
DISM /Online /Cleanup-Image /RestoreHealth
if %errorlevel% neq 0 (
    echo DISM RestoreHealth encountered an issue.
    pause
    goto menu
)
echo Done!
pause
goto menu

:download_apps
cls
echo Downloading specific applications...
echo Select an option:
echo 1. VLC
echo 2. Firefox
echo 3. qBittorrent
echo 4. Neat Download Manager
echo 5. Upgrade all packages
echo 6. Exit

set /p choice=Enter your choice (1-6): 

if "%choice%"=="1" goto vlc
if "%choice%"=="2" goto Firefox
if "%choice%"=="3" goto qBittorrent
if "%choice%"=="4" goto neat
if "%choice%"=="5" goto upgrade
if "%choice%"=="6" goto menu
echo Invalid choice. Please enter a number between 1 and 6.
goto download_apps

:upgrade
cls
echo Upgrading all packages using winget...
winget upgrade --all
if %errorlevel% neq 0 (
    echo please go to https://winget.run/
    pause
    goto menu
)
echo Done!
pause
goto menu

:vlc
cls
echo Installing VLC...
winget install -e --id VideoLAN.VLC
if %errorlevel% neq 0 (
    echo please go to https://www.videolan.org/vlc/
    pause
    goto menu
)
echo Done!
pause
goto menu

:Firefox
cls
echo Installing Firefox...
winget install -e --id Mozilla.Firefox
if %errorlevel% neq 0 (
    echo please go to https://www.mozilla.org/en-US/firefox/new/
    pause
    goto menu
)
echo Done!
pause
goto menu

:qBittorrent
cls
echo Installing qBittorrent...
winget install -e --id qBittorrent.qBittorrent
if %errorlevel% neq 0 (
    echo please go to https://www.qbittorrent.org/download
    pause
    goto menu
)
echo Done!
pause
goto menu

:neat
cls
echo Installing Neat Download Manager...
winget install -e --id JavadMotallebi.NeatDownloadManager
if %errorlevel% neq 0 (
    echo winget installation failed.
    echo Please go to https://www.neatdownloadmanager.com/index.php/en/
    powershell -Command "Invoke-WebRequest -Uri 'https://www.neatdownloadmanager.com/file/NeatDM_setup.exe' -OutFile ([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'CS Downloads', 'NeatDM_setup.exe'))"
    start /wait %USERPROFILE%\Desktop\NeatDM_setup.exe
    echo Installation complete.
    pause
    goto menu
)
echo Done!
pause
goto menu

:activate_windows
cls
echo Activating Windows...
echo                             use PowerShell (Recommended)
echo       1. Right-click on the Windows start menu and select PowerShell or Terminal (Not CMD).
echo       2. Copy and paste the code below and press enter
echo       3. "irm https://get.activated.win | iex"
powershell -Command "irm https://get.activated.win | iex"
echo -or open this in your browser-
echo https://github.com/massgravel/Microsoft-Activation-Scripts?tab=readme-ov-file#download--how-to-use-it
start https://github.com/massgravel/Microsoft-Activation-Scripts?tab=readme-ov-file#download--how-to-use-it
echo Done!
pause
goto menu

:ame_playbook
cls
echo Downloading Atlas OS playbook...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/Atlas-OS/Atlas/releases/download/0.4.0/AtlasPlaybook_v0.4.0.zip' -OutFile ([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'CS Downloads', 'AtlasPlaybook_v0.4.0.zip'))"
if %errorlevel% neq 0 (
    echo Failed to download Atlas OS playbook.
    echo Please visit https://atlasos.net/
    start https://atlasos.net/
    pause
    goto menu
)
echo Downloading AME Wizard to Desktop...
powershell -Command "Invoke-WebRequest -Uri 'https://download.ameliorated.io/AME%20Wizard%20Beta.zip' -OutFile ([System.IO.Path]::Combine([System.Environment]::GetFolderPath('Desktop'), 'CS Downloads', 'AME Wizard Beta.zip'))"
if %errorlevel% neq 0 (
    echo Failed to download AME Wizard.
    echo Please visit https://ameliorated.io/
    start https://ameliorated.io/
    pause
    goto menu
)

echo Downloads completed successfully!
pause
goto menu

:exit_script
cls
echo Exiting script.
start https://catsmoker.github.io
exit /b
