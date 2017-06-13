# RebuildEQ

## Docker Installation

It is possible to run Docker on all OS's via a few commands.
* DEPENDENCIES - Install docker and docker-compose on your machine. 
* build.bat/build.sh - **Should be ran once.** This creates the build image and compiles/configures your binaries. It needs to be ran in the root directory of the git (rebuildeq)
* rebuild.bat/rebuild.sh - This recompiles the code and copies it over. Use this instead of build on minor updates.
* start.bat/start.sh - This starts the environment
* stop.bat/stop.sh - This stops the environment