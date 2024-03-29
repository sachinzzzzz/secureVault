@ECHO OFF

REM Check if the first argument (password) is provided
IF "%~1"=="" (
    ECHO Please provide the password as the first argument.
    EXIT /B 1
)

REM Read the folder name from the text file
set /p folder_name=<folder_name.txt

REM Check if the folder name is empty
IF "%folder_name%"=="" (
    ECHO Folder name is empty or file not found.
    EXIT /B 1
)

set password=%1

echo Enter password 
set /p pass=<password.txt
if NOT "%pass%"=="%password%" goto FAIL

attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" "%folder_name%"
echo Folder Unlocked successfully
goto End

:FAIL
echo Invalid password
goto end

:End

