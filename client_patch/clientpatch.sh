#!/bin/bash
set -e

go run filelistbuilder.go

rm -rf ../deploy/patch/*
cp rof ../deploy/patch/ -r
cp filelist_rof.yml ../deploy/patch/
cp patch.zip ../deploy/patch/
cp eqemupatcher.exe ../deploy/patch/
rm patch.zip
rm filelist_rof.yml
