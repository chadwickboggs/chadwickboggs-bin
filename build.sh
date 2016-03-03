#!/usr/bin/env bash

SCRIPT_HOME=$(dirname $0)

fast=false
quiet=false
silent=false
dryrun=false

USAGE="$(basename $0) <options>

\t	Maven build the current folder.

\t	Options

\t\t		[-h|--help]	This message gets printed only.
\t\t		[-f|--fast]	Do not clean and do skip tests.  Default: \"${fast}\"
\t\t		[-q|--quiet]	Suppress all but the final success and failure messages and stderr.  Default: \"${quiet}\"
\t\t		[-s|--silent]	Suppress stderr.  Default: \"${silent}\"
\t\t		[-n|--dryrun]	Print but do not execute.  Default: \"${dryrun}\"
"

args=`getopt -o "hfqsn" -l "help,fast,quiet,silent,dryrun" -- "$@"`
eval set -- "$args"
while true; do
  case "$1" in
		-h | --help)	echo -e "${USAGE}"; exit;;
		-f | --fast)	fast=true; shift;;
		-q | --quiet)	quiet=true; shift;;
		-s | --silent)	silent=true; shift;;
		-n | --dryrun)	dryrun=true; shift;;
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
	#cmd="${cmd} | ${SCRIPT_HOME}/silent"
fi

if [[ ${quiet} == true ]]; then
	cmd="${cmd} | "${SCRIPT_HOME}/quiet" -e '\[INFO\] BUILD [SF]'"
fi

if [[ ${dryrun} == true ]]; then
	echo "${cmd}"

	exit $?
fi

bash -c "${cmd}"

exit $?

