#!/bin/bash
#
# Publish a file to a repo.
#
set -e

if [ -z "$GIT_REPO" ]; then
  echo "GIT_REPO is not set."
  exit 1;
fi

if [ -z "$FILE_LOCATION" ]; then
  echo "FILE_LOCATION is not set."
  exit 1;
fi

if [ -z "$MY_REPO_DEPLOY_KEY" ]; then
  echo "MY_REPO_DEPLOY_KEY is not set."
  exit 1;
fi

if [ -z "$MY_REPO_LOCATION" ]; then
  echo "MY_REPO_LOCATION is not set."
  exit 1;
fi

echo "Git repo: $GIT_REPO"
echo "File location: $FILE_LOCATION"
echo "My repo deploy key: $MY_REPO_DEPLOY_KEY"
echo "My repo location: $MY_REPO_LOCATION"
