#!/usr/bin/env bash

UNAME="uname -a"
printf "Gathering system information with the $UNAME command: \n\n"
$UNAME

DISKSPACE="df -h"
printf "Gathering diskspace information with $DISKSPACE command: \n\n"
$DISKSPACE