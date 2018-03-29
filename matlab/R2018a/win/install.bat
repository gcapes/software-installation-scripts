@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
	
REM Create variables
set MVER=R2018a
set MROOT="C:\Program Files\MATLAB\%MVER%"
set NVER=25

REM Prepare installation files
REM There are two iso files. The second contains a `common` directory which must be moved into `archives`.
IF EXIST common (
	move /Y common %MVER%\archives
) ELSE IF NOT EXIST %MVER%\archives\common (
	echo !!! ERROR !!!
	echo Directory missing: %MVER%\archives\common
	echo Refer to installation instructions.
	echo https://www.applications.itservices.manchester.ac.uk/show_product.php?id=98^&tab=install
	echo Installation aborted.
	PAUSE
	EXIT
)

REM INSTALL MATLAB
REM The setup.exe in the root directory calls another setup.exe which does the installation. 
REM However, if we execute the root setup.exe, the "/WAIT" isn't transferred to the new process
REM and so the rest of this batch script executes without waiting for setup.exe to finish.
REM As such the start menu activation shortcuts are not deleted because they don't exist when those commands execute.
REM The solution is to call the second setup.exe directly.
START /WAIT %MVER%\bin\win64\setup.exe -inputFile %MVER%\installer_input.txt
mkdir %MROOT%\licenses
IF EXIST %MROOT%\licenses\network.lic del %MROOT%\licenses\network.lic
copy /Y %MVER%\network.lic %MROOT%\licenses\

REM Activation is not required for network licenses so delete shortcuts to prevent confusion
set SHORTCUTDIR=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MATLAB %MVER%
del "%SHORTCUTDIR%\Activate MATLAB %MVER%.lnk"
del "%SHORTCUTDIR%\Deactivate MATLAB %MVER%.lnk"

REM set environment variables
setx MLM_LICENSE_FILE %MROOT%\licenses\network.lic /m

REM Install NAG Toolbox for MATLAB
%MVER%\mbw6i%NVER%ddl_setup.exe /SILENT /DIR=%MROOT%
