#!/bin/sh
#These variables must be set to your value

#lang=Italiano

cd new_tr
# "Jarring" files
jar cvMf ${lang}_pack.jar * 
mv --force ${lang}_pack.jar ..
