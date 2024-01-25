#!/bin/bash
echo "enter file name"
read filename
echo "enter path of it"
read path
cd $path
ls -l | grep $filename
