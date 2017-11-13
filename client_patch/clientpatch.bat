@echo off

go run filelistbuilder.go

rd /s /q %~dp0..\deploy\patch\rof\
xcopy rof\* %~dp0..\deploy\patch\rof\ /e /s /h /d
echo Copying filelist_rof.yml
copy filelist_rof.yml ..\deploy\patch\rof\ /d
echo Copying patch.zip
copy patch.zip ..\deploy\patch\ /d
echo Copying eqemupatcher.exe
copy "%~dp0\eqemupatcher\EQEmu Patcher\bin\Release\eqemupatcher.exe" . /d

echo Cleaning up lingering local files...
del patch.zip
del filelist_rof.yml