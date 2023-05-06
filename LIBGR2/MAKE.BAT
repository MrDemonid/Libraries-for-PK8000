@ECHO OFF
BREAK ON

:: set PL/M tools and sources paths
set SOURCES=.\SOURCE

if %PLM80% == "" goto nodef
set PLMBIN=%PLM80%\BIN
set PLMLIB=%PLM80%\LIB
set PLMINC=%PLM80%\INCLUDE
goto clearprev

:nodef
:: !!! predefined path not found, use default !!!
set PLMBIN=C:\PLMTOOL\BIN
set PLMLIB=C:\PLMTOOL\LIB
set PLMINC=C:\PLMTOOL\INCLUDE

:clearprev
:: clear previous files
del %SOURCES%\*.obj
del %SOURCES%\*.lst
del %PLMLIB%\video2.lib


:: set sources and plm80 paths with ISIS-II style
set :F0:=%PLMBIN%
set :F1:=%SOURCES%
set :F2:=%PLMLIB%


cls
%PLMBIN%\asm80 :F1:video2.m80
if errorlevel == 1 goto error
%PLMBIN%\asm80 :F1:outch.m80
if errorlevel == 1 goto error
%PLMBIN%\asm80 :F1:outstr.m80
if errorlevel == 1 goto error
%PLMBIN%\asm80 :F1:gotoxy.m80
if errorlevel == 1 goto error
%PLMBIN%\asm80 :F1:getxy.m80
if errorlevel == 1 goto error
%PLMBIN%\asm80 :F1:bitmap.m80
if errorlevel == 1 goto error
%PLMBIN%\asm80 :F1:clrln.m80
if errorlevel == 1 goto error
%PLMBIN%\asm80 :F1:deffnt.m80
if errorlevel == 1 goto error

echo ===========================================
echo = Yeehaw! All compiled! No Errors! Ready! =
echo ===========================================

pause
cls
%PLMBIN%\lib.exe < %SOURCES%\mklib.txt
echo .
copy /b %SOURCES%\*.ext %PLMINC%\*.ext
goto end

:error
echo ######################################
echo ######################################
echo ######### AN ERROR OCCURED! ##########
echo ######################################
echo ######################################

:end
pause
del %SOURCES%\*.lst
del %SOURCES%\*.obj

