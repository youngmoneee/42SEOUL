#!/bin/sh
curl -s $1 | grep 'moved here' | cut -d '"' -f2
