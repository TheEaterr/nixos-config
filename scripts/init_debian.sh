#!/bin/sh

scp ./_init_debian.sh ${1}:/tmp/init_debian.sh
ssh ${1} "bash /tmp/init_debian.sh"