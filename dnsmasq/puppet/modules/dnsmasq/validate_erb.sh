#! /usr/bin/bash

erb -P -x -T '-' $1 | ruby -c
