#!/usr/bin/env bash

java_major_version=$(java -fullversion 2>&1|awk '{print $4}'|tr -d '"'|/opt/local/libexec/gnubin/sed 's/\(1\.\)\?\([^_]\)\(\.[0-9]\+_\)\?[0-9]*-.*/\2/')
echo ${java_major_version}

