#!/usr/bin/env bash
##########################################################################
# 到达了里程碑阶段，对某项目执行一次发布的流程
# 1. 更新若干类库依赖的版本号: 批量推进至相应最新里程碑版本
# 2. 更新项目版本号：仅打 git tag
##########################################################################

projectRootPath=$1
newVersion=$2

if [[ -z ${projectRootPath} ]]; then
	echo "projectRootPath param is empty"
	exit 1
fi

if [[ -z ${newVersion} ]]; then
  echo "newVersion param is empty"
	exit 1
fi

cd "${projectRootPath}" || exit 1

# 1. update dependencies
mvn versions:use-latest-versions
echo '【注意】已修改项目的依赖为最新版本，开始验证是否可编译通过。如果编译不通过，请手动处理编译问题或回滚。'
mvn clean compile || exit 1
git add -u
git commit -m '[release] update dependencies to latest version'

# 2. tagging milestone (git tag)
artifactId=$(mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout)
git tag "${artifactId}-${newVersion}"

# 3. release artifact
mvn deploy
