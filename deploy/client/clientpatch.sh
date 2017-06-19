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

rm ../patch/rof/filelistbuilder
rm ../patch/rof/filelistbuilder.yml
rm ../patch/rof/delete.txt
echo "Complete."