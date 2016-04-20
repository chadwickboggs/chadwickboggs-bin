#!/usr/bin/env bash

SCRIPT_HOME=$(dirname $0)

"${SCRIPT_HOME}"/clean_files.sh 'mvn_dependency_tree_*.log'

