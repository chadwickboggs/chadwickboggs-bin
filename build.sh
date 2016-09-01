#!/usr/bin/env bash

SCRIPT_HOME=$(dirname $0)

fast=false
quiet=false
silent=false
skip_tests=''
skip_clean=false
skip_update='-U'
clean_build_logs=false
#use_args='-e -P local'
use_args='-e'
failsafe_debug=false
dryrun=false

FAILSAFE_DEBUG_ARGS="-Dmaven.failsafe.debug"

USAGE="$(basename $0) <options>

\t	Maven build the current folder.

\t	Options

\t\t		[-h|--help]		This message gets printed only.
\t\t		[-f|--fast]		Do not clean and do skip tests.  Default: \"${fast}\"
\t\t		[-q|--quiet]		Suppress all but the final success and failure messages and stderr.  Default: \"${quiet}\"
\t\t		[-s|--silent]		Suppress stderr.  Default: \"${silent}\"
\t\t		[-c|--skip_clean]	Skip clean.  Default: false
\t\t		[-t|--skip_tests]	Skip tests.  Default: false
\t\t		[-u|--skip_update]	Skip update.  Default: false
\t\t		[-b|--clean_build_logs]	Clean build log files.  Default: ${clean_build_logs}
\t\t		[-a|--use_args]		Add args to maven.  Default: \"${use_args}\"
\t\t		[-d|--failsafe_debug]	Enable failesafe debug.  Default: \"${failsafe_debug}\"
\t\t		[-n|--dryrun]		Print but do not execute.  Default: \"${dryrun}\"
"

args=`getopt -o "ha:fqsctunbd" -l "help,use_args,clean_build_logs,fast,quiet,silent,skip_clean,skip_tests,skip_update,failsafe_debug,dryrun" -- "$@"`
eval set -- "$args"
while true; do
  case "$1" in
		-h | --help)				echo -e "${USAGE}"; exit;;
		-f | --fast)				fast=true; skip_tests="-DskipTests -Dmaven.test.skip=true"; shift;;
		-q | --quiet)				quiet=true; shift;;
		-s | --silent)				silent=true; shift;;
		-c | --skip_clean)			skip_clean=true; shift;;
		-t | --skip_tests)			skip_tests="-DskipTests -Dmaven.test.skip=true"; shift;;
		-u | --skip_update)			skip_update=''; shift;;
		-b | --clean_build_logs)	clean_build_logs=true; shift;;
		-a | --use_args)			shift; use_args="$1"; shift;;
		-d | --failsafe_debug)		failsafe_debug=true; shift;;
		-n | --dryrun)				dryrun=true; shift;;
		--) shift; break;;
		*) echo "Internal error!"; exit 1;;
  esac
done

[[ ${clean_build_logs} == true ]] && ${SCRIPT_HOME}/clean_build_logs.sh

cmd="mvn -Dmaven.wagon.http.ssl.insecure=true"

[[ ${failsafe_debug} == true ]] && cmd="${cmd} ${FAILSAFE_DEBUG_ARGS}"

if [[ ${fast} == true ]]; then
	cmd="${cmd} ${use_args} ${skip_tests} install $@"
else
	if [[ ${skip_clean} == true ]]; then
		cmd="${cmd} ${use_args} ${skip_tests} ${skip_update} install $@"
	else
		cmd="${cmd} ${use_args} ${skip_tests} ${skip_update} clean install $@"
	fi
fi

tee_filename="build_$(now).log"
cmd="${cmd} | tee ${tee_filename}"

[[ ${silent} == true ]] && cmd="${cmd} | ${SCRIPT_HOME}/silent"

[[ ${quiet} == true ]] && cmd="${cmd} | ${SCRIPT_HOME}/quiet -e '\[INFO\] BUILD [SF]'"

echo "	Executing: \"${cmd}\""

[[ ${dryrun} == true ]] && exit $?

bash -c "${cmd}"
exit_code=$?

flip -u "${tee_filename}"

exit ${exit_code}

