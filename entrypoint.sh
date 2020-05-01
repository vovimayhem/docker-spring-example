#! /bin/sh

# The Docker App Container's development entrypoint.
# This is a script used by the project's Docker development environment to
# setup the app containers and databases upon runnning.
set -e

if [ -z "${POSTGRES_PASSWORD_FILE}" ]
then
  echo "Not reading secret file for password..."
else
  export SPRING_DATASOURCE_PASSWORD=$(cat "${POSTGRES_PASSWORD_FILE}")
fi

# 11: Execute the given or default command:
exec "$@"
