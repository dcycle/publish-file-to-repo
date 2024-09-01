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

# At this point we will have
# $GIT_REPO: git@github.com:something/something.git
# $FILE_LOCATION: /var/jenkins_home/workspace/google-sheets-to-csv-public/indicateurs.csv
# $MY_REPO_DEPLOY_KEY: contents of a deploy private key, with newlines replaced with ;
# $MY_REPO_LOCATION: ./indicateurs

rm -rf unversioned
mkdir unversioned
cd unversioned
echo "-----BEGIN OPENSSH PRIVATE KEY-----" > my-repo-deploy-key
for i in $(echo $MY_REPO_DEPLOY_KEY | tr ";" "\n")
do
  echo $i >> my-repo-deploy-key
done
echo "-----END OPENSSH PRIVATE KEY-----" >> my-repo-deploy-key
cat my-repo-deploy-key
chmod 600 my-repo-deploy-key
ssh-agent bash -c "ssh-add my-repo-deploy-key; git clone $GIT_REPO my-repo"
cd my-repo
mkdir -p $MY_REPO_LOCATION
cp $FILE_LOCATION $MY_REPO_LOCATION
git add $MY_REPO_LOCATION
git commit -am "I am a robot adding a file to a repo."
git push origin master
cd ../..
rm -rf unversioned
