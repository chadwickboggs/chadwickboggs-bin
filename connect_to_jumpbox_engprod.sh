#!/usr/bin/env bash

uname="$USER"
hname="jumpbox_engprod_west"
identity="~/.ssh/id_rsa"
sshargs=''
be_quiet=false
dry_run=false

USAGE="$(basename $0) <options> \n
\n
\t      SSH to the host named \"jumpbox\" which may be in your \"/etc/hosts\" file. \n
\n
\t      Options \n
\n
\t\t            -h|--help\t\t\t					This message gets printed only. \n
\t\t            -u|--username <the username>\t	The username to ssh as.  Default: \"${uname}\" \n
\t\t            -t|--hostname <the hostname>\t	The hostname to ssh to.  Default: \"${hname}\" \n
\t\t            -i|--identity <ssh identity>\t	The private key file for identity.  Default: \"${identity}\" \n
\t\t            -a|--args <ssh arguments>\t		The arguments to call ssh with.  Default: \"${sshargs}\" \n
\t\t            -q|--quiet <quiet output>\t		Output mininal information. \n
\t\t            -n|--dryrun\t\t\t				Do a dry run (do not execute). \n"

args=`getopt -o "hu:t:i:a:qn" -l "help,user,host,identity,args,quiet,dryrun" -- "$@"`
eval set -- "$args"
while true; do
  case "$1" in
        -h | --help)		echo -e ${USAGE}; exit;;
        -u | --username)	shift; uname="$1"; shift;;
        -t | --hostname)	shift; hname="$1"; shift;;
        -i | --identity)	shift; identity="$1"; shift;;
        -a | --args)		shift; sshargs="$1"; shift;;
        -q | --quiet)		quiet=true; shift;;
        -n | --dryrun)		dry_run=true; shift;;
		--)					shift; break;;
        *)					echo "Internal error!"; exit 1;;
  esac
done

cmd="ssh ${sshargs} -i ${identity} ${uname}@${hname}"

[[ ${be_quiet} == false ]] && echo "	Executing \"$(echo ${cmd} | tr '\n' ' ')\""
[[ ${dry_run} == true ]] && exit

bash -c "${cmd}"

exit $?

