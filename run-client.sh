#!/bin/sh
cobc -m -I src/copy/ src/DUMMBOT.CBL
cobc -x -I src/copy src/CLIENT.CBL
./CLIENT 192.168.42.220 9000 hithere DUMMBOT