@ECHO OFF

REM Check if the first argument (folder name) is provided
IF "%~1"=="" (
    ECHO Please provide the folder name as the first argument.
    EXIT /B 1
)

REM Check if the second argument (password) is provided
IF "%~2"=="" (
    ECHO Please provide the password as the second argument.
    EXIT /B 1
)

SET folder_name=%1
SET password=%2

REM Save the folder name to a text file
echo %folder_name% > folder_name.txt

REM Check if the folder exists
IF NOT EXIST "%folder_name%" (
    ECHO Folder not found.
    EXIT /B 1
)

REM Check if the folder is already locked
IF EXIST "%folder_name%\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" (
    goto :UNLOCK
) ELSE (
    goto :LOCK
)

:CONFIRM
echo Are you sure X? (Y/N)
set/p "cho=>"
if /I "%cho%"=="Y" goto LOCK
if /I "%cho%"=="N" goto END
echo Invalid choice.
goto CONFIRM

:LOCK
ren "%folder_name%" "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo Folder locked
goto End

REM Delete the special file to indicate unlocking
del "%folder_name%\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" >nul 2>&1
attrib -h -s "%folder_name%\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo Folder Unlocked successfully1
goto End

:FAIL
echo Invalid password
goto end

:End
