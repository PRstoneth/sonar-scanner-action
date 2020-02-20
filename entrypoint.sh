#!/bin/bash

set -euo pipefail

declare -a args

add_env_var_as_env_prop() {
  if [ "$1" ]; then
    args+=("-D$2=$1")
  fi
}

add_env_var_as_env_prop "${SONAR_LOGIN:-}" "sonar.login"
add_env_var_as_env_prop "${SONAR_PASSWORD:-}" "sonar.password"
add_env_var_as_env_prop "${SONAR_USER_HOME:-}" "sonar.userHome"
add_env_var_as_env_prop "${SONAR_PROJECT_BASE_DIR:-}" "sonar.projectBaseDir"

PROJECT_BASE_DIR="$PWD"
if [ "${SONAR_PROJECT_BASE_DIR:-}" ]; then
  PROJECT_BASE_DIR="${SONAR_PROJECT_BASE_DIR}"
fi

if ! test -e "$PROJECT_BASE_DIR/.scannerwork"
then
  mkdir "$PROJECT_BASE_DIR/.scannerwork"
fi
if ! test -e "$PROJECT_BASE_DIR/.sonar"
then
  mkdir "$PROJECT_BASE_DIR/.sonar"
fi
chown scanner-cli:scanner-cli "$PROJECT_BASE_DIR/.sonar"
chown scanner-cli:scanner-cli "$PROJECT_BASE_DIR/.scannerwork"
su scanner-cli -c 'SONAR_RUNNER_OPTS="-Xmx2048m -XX:MaxPermSize=512m -XX:ReservedCodeCacheSize=128m" SONAR_USER_HOME=.sonar /opt/sonar-scanner/bin/sonar-scanner '"${args[@]} $@"

