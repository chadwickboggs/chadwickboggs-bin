#!/usr/bin/env bash

ls $* | parallel "echo -n '' > {}"
lspf -q  "{} -name $*" | parallel "echo -n '' > {}"

exit 0

