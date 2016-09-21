#!/usr/bin/env bash

find . -name $@ | parallel "echo -n '' > {}"

exit 0

