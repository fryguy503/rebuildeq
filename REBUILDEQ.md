# Instructions for Rebuild EQ.

## Compile Code
We use 64bit version of binaries.

* Grab git. I use sourcetree (https://www.sourcetreeapp.com/) the latest version sucks though.. 
* Clone the rebuildeq repo. 
* Grab cmake (3.4.1+): https://cmake.org/download/
* Grab ActivePerl 64bit 5.16.3 or greater. http://eqemu.github.io/downloads/ActivePerl-5.16.3.1604-MSWin32-x64-298023.msi
* Grab docker for windows https://www.docker.com/docker-windows (Optional if you only are looking to compile)
* Grab Visual Studio 2015. https://www.visualstudio.com/vs/older-downloads/
* Cmake: run it. When it asks path, set it to root dir of rebuildeq. e.g. D:/code/go/src/github.com/xackery/rebuildeq/build
* Cmake: set the where to build the binaries path to your root dir of rebuildeq/build.. e.g. D:/code/go/src/github.com/xackery/rebuildeq/build
* Cmake: Hit Configure, be sure to set to Visual Studio 14 2015 Win64. Use native compilers (default option)
* Cmake: While configures, you may get red background.. hit configure twice some times it'll go away, or let me know the error. USually lib boost dir not found
* Cmake: Hit generate.
* Extract the \rebuildeq\dependencies\protobuf\lib_x64\libprotobufd.zip into the directory. It's too big for github uncompressed, is why it's zipped.
* Go to your rebuildeq/build directory, and double click the EQEmu.sln file (or right click, open with -> visual studio 2015).

## Prep environment to local test

* Grab docker. https://www.docker.com/docker-windows
* Grab docker-compose. (NOTE: I believe Docker for windows comes with this, so you may skip this step until confirmed)
* Start command line. cd into your rebuildeq root directory. (You can also, in explorer, hold shift and right click the rebuildeq folder, to open command prompt/powershell here.)
* type in: build.bat
* This is going to spin up 4 instances of docker. It may or may not fail, but that's not a huge deal.. you mainly are after the DB and NATS instance, and maybe web.
* When it's done it'll tell you to run start.bat, but ignore that step for now.
* type in: docker-compose run eqemu
* This is going to spin up all linked dependencies of eqemu in the docker-compose.yml file. It's going to fail on the eqemu step, but let it boot for a while, and when it's done tap ctrl+c, to cancel eqemu instance.
* type in: docker ps
* you will see a result of all instances still running. Something similar to this: ![docker ps](https://i.imgur.com/ozxFrlq.png)
* notice that 0.0.0.0: portion, that means the docker instance is binding to your local network device. You can now connect to the SQL database with your ideal client, or:
* Grab SQLyog. This is a SQL client. https://github.com/webyog/sqlyog-community/wiki/Downloads
* You want to configure SQLYog the same as what docker-compose defines, which by default is: MARIADB_DATABASE: eqemu, MARIADB_USER: eqemu, MARIADB_PASSWORD: eqemupass. so user: eqemu, pass: eqemupass , ip address is just 127.0.0.1 (default)
* NAvigate to your /deploy/server/ directory in eqemu. Verify there's a eqemu_config.xml file. If there isn't, copy the one from /docker/eqemu/eqemuconfig_config.xml. This is set up to automatically connect to your local dB instance.
* You may need to edit the entries for db that say mariadb and change them to 127.0.0.1 (this step isn't applicable if you're doing a linux build)
* Go to the releases in github: https://github.com/xackery/rebuildeq/releases  and grab the latest database snapshot
* Inside SQLYog, go to Database, Import.. Execute SQL Script. There's a checkmark that says Abort On error, uncheck it.
* Tap the ... button to browse for directory, and point the SQL file it asks to the one you grabbed from releases. (You may have to extract the file to sql form)
* Execute. You likely will get some errors for some user defined functions, can be ignored.
* Go to your /deploy/server directory, and run shared_memory.exe .. if your db settings are correct, the box will open up, show a few lines of yellow text (and no red text), then poof.
* if it does as described above, go into eqemu_config.xml again in deploy/server and change the server name.
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