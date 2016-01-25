#!/usr/bin/env bash

script_home=$(dirname $0)

"${script_home}"/build.sh && "${script_home}"/redeploy.sh

