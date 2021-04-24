#!/bin/bash

RELEASE="buster"
VERSION="7.1 7.2 7.3 7.4 8.0"
BASE="$HOME/git/docker-php"

for release in $RELEASE
do
	for version in $VERSION
	do
		mkdir $BASE/$release-$version -p
		cat > $BASE/$release-$version/Dockerfile <<EOF
#Created at $(date -u)
FROM php:$version-apache-$release
MAINTAINER Mahyuddin Susanto <udienz@gmail.com>

`cat $BASE/tmpl/debian-base-first.tmpl`
`cat $BASE/tmpl/debian-base-content.tmpl`
`cat $BASE/tmpl/debian-base-cleanup.tmpl`
`cat $BASE/tmpl/debian-base-last.tmpl`

EOF
	done
done