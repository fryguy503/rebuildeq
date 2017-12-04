# Instructions for Rebuild EQ.

## Compile Code
We use 64bit version of binaries.

* Grab git. I use sourcetree (https://www.sourcetreeapp.com/) the latest version sucks though.. 
* Clone the rebuildeq repo. 
* Grab cmake (3.4.1+): https://cmake.org/download/
* Grab ActivePerl 64bit 5.16.3 or greater. http://eqemu.github.io/downloads/ActivePerl-5.16.3.1604-MSWin32-x64-298023.msi
* Grab docker for windows https://www.docker.com/docker-windows (Optional if you only are looking to compile)
* Grab Visual Studio 2015. https://www.visualstudio.com/vs/older-downloads/
* Cmake: run it. When it asks path, set it to root dir of rebuildeq. e.g. D:/code/go/src/github.com/xackery/rebuildeq
* Cmake: set the where to build the binaries path to your root dir of rebuildeq/build.. e.g. D:/code/go/src/github.com/xackery/rebuildeq/build
* Cmake: Hit Configure, be sure to set to Visual Studio 14 2015 Win64. Use native compilers (default option)
* (IF ERROR ABOVE STEP): If you get an error noting it can't find a C compiler, you installed Visual Studio without actually installing C++. The fix is simply, start up visual studio 2015. Create a new project (C++) via the wizard. It'll download additional components (The C compiler), and when it's done, don't even bother saving the project, just hit configure again on cmake.
* Cmake: While configures, you may get red background.. hit configure twice some times it'll go away, or let me know the error. USually lib boost dir not found
* Cmake: Hit generate.
* Extract the \rebuildeq\dependencies\protobuf\lib_x64\libprotobufd.zip into the same directory the zip file is in. The uncompressed one is too big for github, is why it's zipped.
* Go to your rebuildeq/build directory, and double click the EQEmu.sln file (or right click, open with -> visual studio 2015).

## Prep environment to local test

* Grab docker. https://www.docker.com/docker-windows
* Grab docker-compose. (NOTE: I believe Docker for windows comes with this, so you may skip this step until confirmed)
* Start command line. cd into your rebuildeq root directory. (You can also, in explorer, hold shift and right click the rebuildeq folder, to open command prompt/powershell here.)
* type in: install.bat
* This is going to spin up 3 instances of docker, and prep some folders
* When it's done it'll tell you to run start.bat, but ignore that step for now.
* Grab SQLyog. This is a SQL client. https://github.com/webyog/sqlyog-community/wiki/Downloads
* You want to configure SQLYog the same as what docker-compose defines, which by default is: MARIADB_DATABASE: eqemu, MARIADB_USER: eqemu, MARIADB_PASSWORD: eqemupass. so user: eqemu, pass: eqemupass , ip address is just 127.0.0.1 (default)
* Navigate to your /deploy/server/ directory in eqemu. Verify there's a eqemu_config.xml file. If there isn't, copy the one from /docker/eqemu/eqemuconfig_config.xml. This is set up to automatically connect to your local dB instance. Edit it and change your local hosting environment
* Go to the releases in github: https://github.com/xackery/rebuildeq/releases  and grab the latest database snapshot
* Inside SQLYog, go to Database, Import.. Execute SQL Script. There's a checkmark that says Abort On error, uncheck it.
* Tap the ... button to browse for directory, and point the SQL file it asks to the one you grabbed from releases. (You may have to extract the file to sql form)
* Execute. You likely will get some errors for some user defined functions, can be ignored.
* At this point, make sure the earlier section (Compile code) is done, or else the exe files won't exist.
* run deploy/server/shared_memory.exe .. if your db settings are correct, the box will open up, show a few lines of yellow text (and no red text), then poof. You only need to run this if a major DB change happens, most of the time you never do. (A symptom of not running is naked characters on character select)
* run deploy/server/world.exe . See if any errors, and give it a bit. If it gets to the Listening on TCP blah blah step, you're good!
* run deploy/server/zone.exe. Same as above, see if any errors..
* once both seem to be up, log in like usual via everquest and see if your server appears. See if you can connect. Some times you won't be able to and require port forwarding, but i'll do that for another instruction set.

## Using the dev environment for local test

* In order to test your dev environment, it's suggseted to update your account status to have GM access. You do this in sqlyog by going to database, account, and finding your login. Set status to 200+
* With the minimum prep environment, you have one world.exe and zone.exe. This means you can't zone, since each zone you want to support requires another zone.exe. So, e.g. if you have 2 zone.exe ran, you can hop between zones.
* The reason I only roll with just 1 zone and 1 world is, you can #gm 1 while targetting yourself to flag GM, /camp, and instantly log out. When logged out you can kill the zone.exe, compile code, and spin it back up. Your char re-entering the game will access the new spun up zone.
* Here is easiest way to test on the environment:
    Create a character on the test server
    #gm 1
    #level 60
    #setallbuilds 5 - sets all builds to 5
    #setallskills 400 - sets all skills to 400
    #findspell 3m - get the spell_id of the 3 million GM HP Buff (should be 6824)
    #cast <spell_id of 3mGMHPBuff> - to cast the GM 3 million HP buff and now you don't have to worry about dying
    #heal - to heal yourself to full
    #spawn Test 0 60 - to spawn a lvl 60 mob
    You can find all commands here: https://github.com/xackery/rebuildeq/wiki/Commands