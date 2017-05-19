#!/bin/sh

# exit script, if error
set -e

# define colors
RED=`tput setaf 1`
GREEN=`tput setaf 2`
NOCOLOR=`tput sgr0`

echo "${GREEN}Running Spellchecker v1.0.0 (2017-05-19)${NOCOLOR}"


if [ $# -eq 0 ] ; then
  echo "No repo specified"
  exit
fi


git clone git@github.com:fixTypos/$1.git ../$1 && cd ../$1 && git branch fix_typos && git checkout fix_typos && misspell -w -locale US .
