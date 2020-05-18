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
set MVER=R2020a
set MROOT="C:\Program Files\MATLAB\%MVER%"
set NVER=25
set INSTALLER_DIR=%cd%\%MVER%

REM Prepare installation files
REM There are three iso files because the ESD can't reliably handle iso files > 4Gb.
REM As such, directories have been moved around to best fit into 3 iso files,
REM and need moving back to the original locations.
IF NOT EXIST %INSTALLER_DIR%\archives (
	REM archives directory hasn't been copied.
	IF EXIST archives (
		REM archives dir exists at same level, so move it to the right place
		move /Y archives %INSTALLER_DIR%
	) ELSE (
	echo !!! USER ERROR !!!
	echo "archives" directory missing from current directory.
	echo Refer to installation instructions.
	echo https://www.applications.itservices.manchester.ac.uk/show_product.php?id=98^&tab=install
	echo Installation aborted.
	PAUSE
	EXIT
	)
)

IF NOT EXIST %INSTALLER_DIR%\archives\common (
	REM common directory hasn't been copied.
	IF EXIST common (
		REM common dir exists at same level, so move it to the right place.
		move /Y common %INSTALLER_DIR%\archives
	) ELSE (
		echo !!! USER ERROR !!!
		echo "common" directory missing from current directory.
		echo Refer to installation instructions.
		echo https://www.applications.itservices.manchester.ac.uk/show_product.php?id=98^&tab=install
		echo Installation aborted.
		PAUSE
		EXIT
	)
)

IF NOT EXIST %INSTALLER_DIR%\archives\common\examples (
	REM examples directory hasn't been copied.
	IF EXIST examples (
		REM example dir exists at same level, so move it to the right place.
		move /Y examples %INSTALLER_DIR%\archives\common
	) ELSE (
		echo !!! USER ERROR !!!
		echo "examples" directory missing from current directory.
		echo Refer to installation instructions.
		echo https://www.applications.itservices.manchester.ac.uk/show_product.php?id=98^&tab=install
		echo Installation aborted.
		PAUSE
		EXIT
	)
)

IF EXIST %MROOT%\licenses\network.lic del %MROOT%\licenses\network.lic
mkdir %MROOT%\licenses
copy /Y %INSTALLER_DIR%\network.lic %MROOT%\licenses\

REM INSTALL MATLAB
REM The setup.exe in the root directory calls another setup.exe which does the installation.
REM However, if we execute the root setup.exe, the "/WAIT" isn't transferred to the new process
REM and so the rest of this batch script executes without waiting for setup.exe to finish.
REM As such the start menu activation shortcuts are not deleted because they don't exist when those commands execute.
REM The solution is to call the second setup.exe directly.
START /WAIT %MVER%\bin\win64\setup.exe -inputFile %MVER%\installer_input.txt

REM Activation is not required for network licenses so delete shortcuts to prevent confusion
set SHORTCUTDIR=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MATLAB %MVER%
del "%SHORTCUTDIR%\Activate MATLAB %MVER%.lnk"
del "%SHORTCUTDIR%\Deactivate MATLAB %MVER%.lnk"

REM set environment variables
setx MLM_LICENSE_FILE %MROOT%\licenses\network.lic /m

REM Install NAG Toolbox for MATLAB
.\mbw6i%NVER%ddl_setup.exe /SILENT /DIR=%MROOT%
