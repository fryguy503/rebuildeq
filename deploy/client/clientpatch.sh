#!/bin/bash
set -e

#used to deploy a client patch
cd rof
./filelistbuilder

if [ ! -d ../patch ]; then
   echo "Making patch directory..."
   mkdir ../patch
fi

if [ ! -d ../patch/rof ]; then
   echo "Making patch/rof directory..."
   mkdir ../patch/rof
fi

cp -R * ../patch/rof/

rm ../patch/filelistbuilder
rm ../patch/filelistbuilder.yml
rm ../patch/delete.txt
echo "Complete."