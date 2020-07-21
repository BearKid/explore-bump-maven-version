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

mvn versions:use-latest-versions versions:set -DnewVersion=${newVersion}
git commit
