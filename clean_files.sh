#!/usr/bin/env bash

files=$(find . -name "$*")

[[ $(echo -n ${files} | wc -l) > 0 ]] && rm -v ${files}

