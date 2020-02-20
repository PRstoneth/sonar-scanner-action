#!/bin/bash

set -euo pipefail

declare -a args

add_env_var_as_env_prop() {
  if [ "$1" ]; then
    args+=("-D$2=$1")
  fi
}

OLDUID=$(id -u scanner-cli)
OLDGID=$(id -g scanner-cli)
usermod -u $UID scanner-cli
groupmod -g $GID scanner-cli
find / -user $OLDUID -exec chown -h $UID {} \;
find / -gropu $OLDGID -exec chgrp -h $GID {} \;
usermod -g $GID scanner-cli

add_env_var_as_env_prop "${SONAR_LOGIN:-}" "sonar.login"
add_env_var_as_env_prop "${SONAR_PASSWORD:-}" "sonar.password"
add_env_var_as_env_prop "${SONAR_USER_HOME:-}" "sonar.userHome"
add_env_var_as_env_prop "${SONAR_PROJECT_BASE_DIR:-}" "sonar.projectBaseDir"

PROJECT_BASE_DIR="$PWD"
if [ "${SONAR_PROJECT_BASE_DIR:-}" ]; then
  PROJECT_BASE_DIR="${SONAR_PROJECT_BASE_DIR}"
fi

export SONAR_USER_HOME="$PROJECT_BASE_DIR/.sonar"
su - scanner-cli -c "sonar-scanner \"${args[@]}\""
