#!/usr/bin/env bash
projectRootPath=$1
newVersion=$2

if [[ -z ${projectRootPath} ]]; then
	echo "param is empty"
	exit 1
fi

cd "${projectRootPath}" || exit 1

# 1. update dependencies
mvn versions:use-latest-versions
echo '【注意】已修改项目的依赖为最新版本，开始验证是否可编译通过。如果编译不通过，请手动处理编译问题或回滚。'
mvn clean compile || exit 1
git add pom.xml
git commit -m '[release] update dependencies to latest version'

# 2. tagging milestone
### 2.1 pom project version
mvn versions:set
git add pom.xml
git commit --amend -m '[release] update dependencies to latest version, bump project version'

### 2.2 git tag
artifactId=$(mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout)
if [[ -z ${newVersion} ]]; then
  newVersion=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)
fi
git tag "${artifactId}-${newVersion}"

# 3. release artifact
mvn deploy
