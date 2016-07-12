#!/usr/bin/env bash

ls $* | parallel "echo -n '' > {}"
lspf "{} -name $*" | parallel "echo -n '' > {}"

exit 0

