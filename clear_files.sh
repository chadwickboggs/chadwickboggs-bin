#!/usr/bin/env bash

ls $@ | parallel "echo -n '' > {}"

exit 0

