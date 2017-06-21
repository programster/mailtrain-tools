#!/bin/bash

# ensure running bash
if ! [ -n "$BASH_VERSION" ];then
    echo "this is not bash, calling self with bash....";
    SCRIPT=$(readlink -f "$0")
    /bin/bash $SCRIPT
    exit;
fi

# Get the path to script just in case executed from elsewhere.
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

# Set the tag for this image. 
TAG="mailtrain-tools"

# Copy the docker file up and run it in order to build the container.
# We need to move the dockerfile up so that it can easily add everything to the container.
cp -f Dockerfile ../../.
cp -f .dockerignore ../../.
cd ../../.

# Ask the user if they want to use the docker cache
read -p "Do you want to use a cached build (y/n)? " -n 1 -r
echo ""   # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    docker build --pull --tag $TAG .
else
    docker build --no-cache --pull --tag $TAG .
fi

# Remove the duplicated Dockerfile after the build.
rm $SCRIPTPATH/../../Dockerfile
rm $SCRIPTPATH/../../.dockerignore


echo "Run the container with the following command:"
echo "bash run-container.sh"
