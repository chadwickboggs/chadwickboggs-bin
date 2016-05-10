#!/usr/bin/env bash

lspf "{} -name \"$*\"" | parallel "echo -n '' > {}"

