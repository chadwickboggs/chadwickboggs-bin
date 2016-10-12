#!/usr/bin/env bash

[[ $# == 0 ]] && echo "Filenames must be specified on the command line.  Exiting." && exit 1

files=$(find . -name "$*")

[[ $(echo -n ${files} | wc -l) == 0 ]] && exit 0

rm -v ${files}

