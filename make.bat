@echo off

set TAG_VER=%1

if "%TAG_VER%"=="" (
  echo usage make tag_version
  exit 1
)

set DIR_NAME=libuv-%TAG_VER%
set TAG_NAME=v%TAG_VER%
set TAG_URL=https://github.com/libuv/libuv/archive/%TAG_NAME%.zip

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


%VS100COMNTOOLS%\..\..\vc\vcvarsall.bat

"%DIR_NAME%\vcbuild.bat" x86 shared release || exit 1
