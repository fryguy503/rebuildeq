#!/bin/bash
set -e

#used to deploy a client patch
cd rof
./filelistbuilder
cp -R * ../patch/
rm ../patch/filelistbuilder
rm ../patch/delete.txt