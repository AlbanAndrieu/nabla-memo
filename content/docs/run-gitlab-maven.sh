#!/bin/bash
#set -xv
#set -eo pipefail

# shellcheck disable=SC2034
WORKING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
# shellcheck source=/dev/null
source "${HOME}/step-0-color.sh"

export GITLAB_FULL_PRIVATE_TOKEN=${GITLAB_FULL_PRIVATE_TOKEN:-"glpat-XXX"}
export GLB_GROUP_PJT_ID="45107021"                      # "<numeric project id>";
export MAVEN_GROUP_ID="com/jusmundi"                    # "<maven-group-id replace . with />";
export MAVEN_ARTIFACT_ID="keycloak-theme-jusmundi"      # "<maven-artifact-id>";
export MAVEN_ARTIFACT_VERSION="1.0.0-SNAPSHOT"          # "<maven-artifact-version>"
export GLB_ARTIFACT_FILE_NAME="1.0.0-20230419.155427-1" # "<maven-artifact-version w/o SNAPSHOT>-<file-specific-number as found in gitlab>";
FILE_TYPE=".jar"

export FILE_NAME="$MAVEN_ARTIFACT_ID-$GLB_ARTIFACT_FILE_NAME$FILE_TYPE"

curl -k --header "PRIVATE-TOKEN:${GITLAB_FULL_PRIVATE_TOKEN}" "https://gitlab.com/api/v4/projects/${GLB_GROUP_PJT_ID}/packages/"
GLB_GROUP_PKG_ID="14042780" # "<numeric package id>";

curl --header "PRIVATE-TOKEN: ${GITLAB_FULL_PRIVATE_TOKEN}" "https://gitlab.com/api/v4/projects/${GLB_GROUP_PJT_ID}/packages/${GLB_GROUP_PKG_ID}"

echo -e "${magenta} Running curl for $MAVEN_ARTIFACT_ID-$GLB_ARTIFACT_FILE_NAME ${NC}"

rm -f "${FILE_NAME}"
#  -O test.jar
echo -e "${magenta} curl --header \"Private-Token: ${GITLAB_FULL_PRIVATE_TOKEN}\" \"https://gitlab.com/api/v4/projects/${GLB_GROUP_PJT_ID}/packages/maven/${MAVEN_GROUP_ID}/$MAVEN_ARTIFACT_ID/$MAVEN_ARTIFACT_VERSION/${FILE_NAME}\" >> ${FILE_NAME} ${NC}"
curl --header "Private-Token: ${GITLAB_FULL_PRIVATE_TOKEN}" "https://gitlab.com/api/v4/projects/${GLB_GROUP_PJT_ID}/packages/maven/${MAVEN_GROUP_ID}/$MAVEN_ARTIFACT_ID/$MAVEN_ARTIFACT_VERSION/${FILE_NAME}" >>${FILE_NAME}

exit 0
