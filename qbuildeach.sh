#!/usr/bin/env bash

ls -d $1 | parallel 'cd "{}"; qbuild.sh'

