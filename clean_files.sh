#!/usr/bin/env bash

files=$(find . -name "$*")

[[ $(echo ${files} | wc -l) > 0 ]] && rm -v ${files}

