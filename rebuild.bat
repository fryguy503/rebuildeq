@echo off

:: Rebuilds binaries to copy them over. It is recommended ending the processes before this runs, 
:: e.g. turn off zone/world binaries.
:: RUN THIS after the first and only run of build.sh

echo Building binaries...
docker run -v %cd%:/src -v %cd%\deploy\server:/eqemu buildeq

echo Copying binaries...
copy bin\* deploy\server\