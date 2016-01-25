#!/usr/bin/env bash

if [[ $# -gt 0 && "$1" -eq 'fast' ]]; then
	shift
	mvn -e -P local install -DskipTests $@
else
	mvn -e -U -P local clean install $@
fi

