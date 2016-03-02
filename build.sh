#!/usr/bin/env bash

fast=false
quiet=false
silent=false

USAGE="$(basename $0) <options>

\t	Maven build the current folder.

\t	Options

\t\t		[-h|--help]	This message gets printed only.
\t\t		[-f|--fast]	Do not clean and do skip tests.  Default: \"${fast}\"
\t\t		[-q|--quiet]	Suppress all but the final success and failure messages and stderr.  Default: \"${quiet}\"
\t\t		[-s|--silent]	Suppress stderr.  Default: \"${silent}\"
"

args=`getopt -o "hfqs" -l "help,fast,quiet,silent" -- "$@"`
eval set -- "$args"
while true; do
  case "$1" in
		-h | --help)	echo -e "${USAGE}"; exit;;
		-f | --fast)	fast=true; shift;;
		-q | --quiet)	quiet=true; shift;;
		-s | --silent)	silent=true; shift;;
		--) shift; break;;
		*) echo "Internal error!"; exit 1;;
  esac
done

if [[ ${fast} == true ]]; then
	cmd="mvn -e -P local install -DskipTests $@"
else
	cmd="mvn -e -U -P local clean install $@"
fi

if [[ ${silent} == true ]]; then
	cmd="${cmd} 2> /dev/null"
fi

if [[ ${quiet} == true ]]; then
	cmd="${cmd} | grep '\[INFO\] BUILD [SF]'"
fi

bash -c "${cmd}"

exit $?

