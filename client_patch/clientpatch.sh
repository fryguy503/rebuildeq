#!/bin/bash
set -e

go run filelistbuilder.go

rm -rf ../deploy/patch/*
cp rof ../deploy/patch/ -r
cp filelist_rof.yml ../deploy/patch/rof/
cp patch.zip ../deploy/patch/
cp RebuildEQ.exe ../deploy/patch/
rm patch.zip
