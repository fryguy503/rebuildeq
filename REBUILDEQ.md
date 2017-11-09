# Instructions for Rebuild EQ.

We use 64bit version of binaries.

* Grab git. I use sourcetree (https://www.sourcetreeapp.com/) the latest version sucks though.. 
* Clone the rebuildeq repo. 
* Grab cmake (3.4.1+): https://cmake.org/download/
* Grab ActivePerl 64bit 5.16.3 or greater. http://eqemu.github.io/downloads/ActivePerl-5.16.3.1604-MSWin32-x64-298023.msi
* Grab docker for windows https://www.docker.com/docker-windows (Optional if you only are looking to compile)
* Grab Visual Studio 2015. https://www.visualstudio.com/vs/older-downloads/
* Cmake: run it. When it asks path, set it to root dir of rebuildeq.
* Cmake: Hit Configure, be sure to set to Visual Studio 14 2015 Win64. Use native compilers (default option)
* Cmake: While configures, you may get red background.. hit configure twice some times it'll go away, or let me know the error. USually lib boost dir not found
* Cmake: Hit generate.
* Go to your rebuildeq/build directory, and double click the EQEmu.sln file (or right click, open with -> visual studio 2015).