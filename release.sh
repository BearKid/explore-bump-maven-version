#!/usr/bin/env bash
projectRootPath=$1
newVersion=$2

if [[ -z ${projectRootPath} ]]; then
	echo "param is empty"
	exit 1
fi

if [[ -z ${newVersion} ]]; then
	echo "param is empty"
	exit 1
fi

cd "${projectRootPath}" || exit 1

# modify pom to update dependencies
mvn versions:use-latest-versions versions:set -DnewVersion="${newVersion}"
mvn clean complie || exit 1

# commit to scm
git add pom.xml
git commit -m '[release] update dependencies to latest version, bump project version'
git tag "${newVersion}"

# release artifact
#mvn deploy
