#!/usr/bin/env bash

# Test the Docker image to see if it runs PHP successfully.
# Usage: test.sh [tag]
#   Where tag is the image tag you want to test. Can be 'latest', 'jessie' or
#   'wheezy'.

# Name of Docker image to test.
DOCKER_IMG=cboulanger/docker-phpfarm

# Tag of image to test e.g. 'latest', 'wheezy'.
TAG=latest

# Ports to test for.
ports='8071 8072 8073 8074 8080'

# Create the docker run option for publishing ports.
publishOption=''
for port in $ports; do
  publishOption="$publishOption -p ${port}:${port}"
done

container=$( docker run -d $publishOption --name phpfarm $DOCKER_IMG:$TAG )

if [ -z "$container" ]; then
    echo -e "\e[31mFailed to start container\e[0m"
    exit 1
else
    echo "$TAG container $container started. Waiting to start up"
fi

# Wait for container to start.
sleep 5s

# Record results of the port test.
portTestResult=0

# Test if all required ports are showing a PHP version.
for port in $ports; do

    result=$(curl --silent http://localhost:$port/ | grep -Eo 'PHP Version [0-9]+\.[0-9]+\.[0-9]+')

    if [ -z "$result" ]; then
        echo -e "Port $port: \e[31mFAILED\e[0m"
        # Set port test result to "error" (non-zero) if any port test fails.
        portTestResult=1
    else
        echo -e "Port $port: \e[32m$result\e[0m"
    fi
done

# Display status of PHP extensions.
echo -e 'Checking extensions...\n\n'
docker exec -it phpfarm php-7.4 /extensions.php

docker kill phpfarm > /dev/null
docker rm phpfarm > /dev/null

echo
echo "Stopped and removed container"

# Return the port test result as representing the entire script's result.
exit $portTestResult

