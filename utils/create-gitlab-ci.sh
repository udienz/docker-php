#!/bin/bash

RELEASE="buster"
VERSION="7.1 7.2 7.3 7.4 8.0"
BASE="$HOME/git/docker-php"
OUT=$BASE/.gitlab-ci.yml

rm -f $OUT
cat > $OUT  <<EOF
image: docker:latest
services:
 - docker:dind
stages:
 - build
 - test
 - deploy
before_script:
 - docker info
EOF

for release in $RELEASE
do
	for version in $VERSION
	do
	echo "
build-$release-$version:
 stage: build
 script:
  - docker pull udienz/php:$release-$version
  - docker build -t php-$release-$version \$CI_PROJECT_DIR/$release-$version
  - docker tag php-$release-$version udienz/php:$release-$version
  - docker login -u=\"\$DOCKERUSER\" -p=\"\$DOCKERPASS\"
  - docker push udienz/php:$release-$version" >> $OUT
	done
done
