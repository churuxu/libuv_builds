@echo off

set TAG_VER=%1

if "%TAG_VER%"=="" (
  echo "usage make tag_version vs_version"
  echo "  tag_version like 1.7.0"
  echo "  vs_version like vs2010"
  exit 1
)

set DIR_NAME=libuv-%TAG_VER%
set TAG_NAME=v%TAG_VER%
set TAG_URL=https://github.com/libuv/libuv/archive/%TAG_NAME%.zip



if "%2" == "vs2010" goto vs2010
if "%2" == "vs2012" goto vs2012
if "%2" == "vs2013" goto vs2013
if "%2" == "vs2015" goto vs2015
goto build

:vs2015
call "%VS140COMNTOOLS%\..\..\vc\vcvarsall.bat"
if defined VCINSTALLDIR goto build
echo not installed vs2015
exit 1

:vs2013
call "%VS120COMNTOOLS%\..\..\vc\vcvarsall.bat"
if defined VCINSTALLDIR goto build
echo not installed vs2013
exit 1

:vs2012
call "%VS110COMNTOOLS%\..\..\vc\vcvarsall.bat"
if defined VCINSTALLDIR goto build
echo not installed vs2012
exit 1

:vs2010
call "%VS100COMNTOOLS%\..\..\vc\vcvarsall.bat"
if defined VCINSTALLDIR goto build
echo not installed vs2010
exit 1


:build

if not exist %TAG_NAME%.zip (
  echo download source ...
  curl -fsSL -o %TAG_NAME%.zip %TAG_URL% || exit 1
)

if not exist %DIR_NAME% (
  echo unzip source ...
  7z x -ry %TAG_NAME%.zip || exit 1
)

if not exist gyp (
  echo download gyp tool from googlesource ...
  git clone https://chromium.googlesource.com/external/gyp.git gyp
)

if not exist gyp (
  echo download gyp tool from github ...
  git clone https://github.com/svn2github/gyp.git gyp || exit 1  
)


if not exist %DIR_NAME%\build\gyp (
  echo install gyp tool ...
  xcopy /S /Q /Y gyp %DIR_NAME%\build\gyp\  || exit 1
)



cmd /c "%DIR_NAME%\vcbuild.bat" x86 shared release || exit 1
cmd /c "%DIR_NAME%\vcbuild.bat" x86 shared debug || exit 1

7z a libuv.zip %DIR_NAME%\Debug\libuv.* %DIR_NAME%\Release\libuv.* %DIR_NAME%\include\* %DIR_NAME%\LICENSE

