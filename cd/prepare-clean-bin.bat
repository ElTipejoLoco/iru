@echo off
set filename=iru
set working_name=iru
pushd %~dp0

echo Attempting to prepare the original game files.
echo ############################################################################
echo:

if "%~1"=="" goto :NOISO

:: Verify that the included file is a bin file
echo "%~1" | find /i ".bin" >nul
if errorlevel 1 (
    echo Supplied file was not a .bin file!
    goto :NOISO
)

mkdir orig
mkdir %working_name%

echo Normalizing bin name...
copy "%~1" "%filename%_original.bin"
echo:

echo Writing out a new cue file...
echo FILE "%filename%_original.bin" BINARY>"%filename%_original.cue"
echo   TRACK 01 MODE2/2352>>%filename%_original.cue
echo     INDEX 01 00:00:00>>%filename%_original.cue
echo.
echo:

echo Writing out a cue file for the working build...
echo FILE "%filename%.bin" BINARY>"%filename%.cue"
echo   TRACK 01 MODE2/2352>>%filename%.cue
echo     INDEX 01 00:00:00>>%filename%.cue
echo.
echo:

echo Extracting files...
..\tools\psximager\psxrip.exe "%filename%_original.cue" %working_name%
echo:

echo Backing up files as the original files...
:: /e - Copies all subdirectories, even if empty. /h - Include hidden and system files. /q - Copy silently
xcopy /e /h /q %working_name% orig
echo:

echo Moving system file to project root...
copy %working_name%.sys ..\%working_name%.sys
echo:

echo Making the needed empty folders...
mkdir ..\format
mkdir ..\format\AREA1
mkdir ..\format\AREA2
mkdir ..\format\AREA3
mkdir ..\format\AREA4
mkdir ..\format\AREA5
mkdir ..\format\AREA6
mkdir ..\format\AREA7
mkdir ..\format\AREA8
mkdir ..\format\AREA9
mkdir ..\ins
echo:

echo Success~!
goto :EXIT

:NOISO
echo To extract your base copy of the game, drop the first bin track here instead of running the bat.
echo Make sure you're not dropping the cue file either!
goto :EXIT

:EXIT
popd
echo Press any key to close this window
pause >nul
exit