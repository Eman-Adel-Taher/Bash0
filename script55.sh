#!/bin/bash
# more simple :) #
echo $(echo $(tr -dc A-Za-z < /dev/urandom | head -c 16)abcd123+-= | fold -w 1 | shuf | tr -d "\n")
