#! /bin/sh

APPDIR=$(git rev-parse --show-toplevel)
rm ${APPDIR}/config/database.yml
