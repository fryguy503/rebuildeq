@echo off

:: Rebuilds binaries to copy them over. It is recommended ending the processes before this runs, 
:: e.g. turn off zone/world binaries.
:: RUN THIS after the first and only run of build.sh
if not exist "deploy\web\application\cache" echo Making web cache directory... && mkdir deploy\web\application\cache
if not exist "deploy\web\application\logs" echo Making web log directory... && mkdir deploy\web\application\logs

echo Exiting any eqemu docker instances
docker-compose down

echo Building binaries...
docker run -v %cd%:/src -v %cd%\deploy\server:/eqemu buildeq

echo Copying binaries...
copy bin\* deploy\server\