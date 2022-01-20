@echo off
cls
SETLOCAL ENABLEDELAYEDEXPANSION

if [%1]==[] GOTO USAGE

REM Feel free to change the default values of the following variables in order to change the jpg output
REM QUALITY is the percentage quality of the original, from 0 to 100, the higher the percentage the bigger the file will be
set QUALITY=100
set DPI=300

set ALPHABITS=2
set FIRSTPAGE=1
set LASTPAGE=9999
REM Memory in MB
set MEMORY=1024

set EXECUTABLE="gs/gswin32c.exe"
if /I %Processor_Architecture%==AMD64 set EXECUTABLE="gs/gswin64c.exe"
if /I "%PROCESSOR_ARCHITEW6432%"=="AMD64" set EXECUTABLE="gs/gswin64c.exe"

echo Running %EXECUTABLE% & echo.

for %%x in (%*) do (
    set PDFFILE=%%~x
    set JPGFILE=!PDFFILE:.pdf=-!%%d.jpg

    %~dp0%EXECUTABLE% -sDEVICE=jpeg -sOutputFile="!JPGFILE!" -r%DPI% -dNOPAUSE -dFirstPage=%FIRSTPAGE% -dLastPage=%LASTPAGE% -dJPEGQ=%QUALITY% -dGraphicsAlphaBits=%ALPHABITS%  -dTextAlphaBits=%ALPHABITS%  -dNumRenderingThreads=4 -dBufferSpace=%MEMORY%000000  -dBandBufferSpace=%MEMORY%000000 -c %MEMORY%000000 setvmthreshold -f "!PDFFILE!" -c quit   
)

echo. & echo PDF pages extracted as JPG files successfully.

:END
echo.
pause
EXIT

:USAGE
echo.
echo Usage:
echo Just drag and drop PDF file/s on this batch file
goto END
