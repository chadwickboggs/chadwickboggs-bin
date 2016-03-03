#!/usr/bin/env bash

SCRIPT_HOME=$(dirname $0)

fast=false
quiet=false
silent=false
skip_tests=''
use_args='-e -P local'
dryrun=false

USAGE="$(basename $0) <options>

\t	Maven build the current folder.

\t	Options

\t\t		[-h|--help]		This message gets printed only.
\t\t		[-f|--fast]		Do not clean and do skip tests.  Default: \"${fast}\"
\t\t		[-q|--quiet]		Suppress all but the final success and failure messages and stderr.  Default: \"${quiet}\"
\t\t		[-s|--silent]		Suppress stderr.  Default: \"${silent}\"
\t\t		[-t|--skip_tests]	Skip tests.  Default: \"${skip_tests}\"
\t\t		[-a|--use_args]		Add args to maven.  Default: \"${use_args}\"
\t\t		[-n|--dryrun]		Print but do not execute.  Default: \"${dryrun}\"
"

args=`getopt -o "hfqstn" -l "help,fast,quiet,silent,skip_tests,dryrun" -- "$@"`
eval set -- "$args"
while true; do
  case "$1" in
		-h | --help)		echo -e "${USAGE}"; exit;;
		-f | --fast)		fast=true; skip_tests="-DskipTests"; shift;;
		-q | --quiet)		quiet=true; shift;;
		-s | --silent)		silent=true; shift;;
		-t | --skip_tests)	skip_tests="-DskipTests"; shift;;
		-a | --use_args)	shift; use_args="$1"; shift;;
		-n | --dryrun)		dryrun=true; shift;;
		--) shift; break;;
		*) echo "Internal error!"; exit 1;;
  esac
done

if [[ ${fast} == true ]]; then
	cmd="mvn ${use_args} ${skip_tests} install $@"
else
	cmd="mvn ${use_args} ${skip_tests} -U clean install $@"
fi

if [[ ${silent} == true ]]; then
	cmd="${cmd} 2> /dev/null"
	#cmd="${cmd} | ${SCRIPT_HOME}/silent"
fi

if [[ ${quiet} == true ]]; then
	cmd="${cmd} | "${SCRIPT_HOME}/quiet" -e '\[INFO\] BUILD [SF]'"
fi

echo "${cmd}"

[[ ${dryrun} == true ]] && exit $?

bash -c "${cmd}"

exit $?

