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


REM INSTALL MATLAB
REM The setup.exe in the root directory calls another setup.exe which does the installation. 
REM However, if we execute the root setup.exe, the "/WAIT" isn't transferred to the new process
REM and so the start menu shortcuts are not deleted after installation because this script finishes execution before the MATLAB installation is complete.
REM So the solution is to call the second setup.exe directly.
cd matlabR2015aSP1\bin\win64
START /WAIT setup.exe -inputFile ..\..\installer_input.txt
mkdir "C:\Program Files\MATLAB\R2015aSP1\licenses\"
IF EXIST "C:\Program Files\MATLAB\R2015aSP1\licenses\network.lic" del "C:\Program Files\MATLAB\R2015aSP1\licenses\network.lic"
copy /Y ..\..\network.lic "C:\Program Files\MATLAB\R2015aSP1\licenses\"

REM Activation is not required for network licenses so delete shortcuts to prevent confusion
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MATLAB\R2015aSP1\Activate MATLAB R2015aSP1.lnk"
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MATLAB\R2015aSP1\Deactivate MATLAB R2015aSP1.lnk"

REM set environment variables
setx MLM_LICENSE_FILE "C:\Program Files\MATLAB\R2015aSP1\licenses\network.lic" /m

REM Install NAG Toolbox for MATLAB
cd ..\..\
mbw6i24ddl_setup.exe /SILENT /DIR="C:\Program Files\MATLAB\R2015aSP1"
