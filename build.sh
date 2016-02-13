#!/usr/bin/env bash

fast=false
quiet=false

USAGE="$(basename $0) <options> \n
\n
\t	Maven build the current folder. \n
\n
\t	Options \n
\n
\t\t		[-h|--help]\t\t\t\t		This message gets printed only. \n
\t\t		[-f|--fast] <fast>\t	Do not clean and do skip tests.  Default: \"${fast}\" \n
\t\t		[-q|--quiet] <quiet>\t	Suppress all but the final success and failure messages.  Default: \"${quiet}\" \n
"

args=`getopt -o "hfq" -l "help,fast,quiet" -- "$@"`
eval set -- "$args"
while true; do
  case "$1" in
		-h | --help)	echo -e ${USAGE}; exit;;
		-f | --fast)	fast=true; shift;;
		-q | --quiet)	quiet=true; shift;;
		--) shift; break;;
		*) echo "Internal error!"; exit 1;;
  esac
done

if [[ ${fast} == true ]]; then
	if [[ ${quiet} == true ]]; then
		mvn -e -P local install -DskipTests $@ | grep '\[INFO\] BUILD [SF]'
	else
		mvn -e -P local install -DskipTests $@
	fi
else
	if [[ ${quiet} == true ]]; then
		mvn -e -U -P local clean install $@ | grep '\[INFO\] BUILD [SF]'
	else
		mvn -e -U -P local clean install $@
	fi
fi

