#!/bin/sh

# Create directories, if they don't exist
mkdir -p /root/data/es{0,1,2,3,4,5,6,7,8,9}
mkdir -p /root/data/{redis,portainer,jenkins}

# Set correct owners and make them available for Docker
find /root/data/ -maxdepth 1 -type d -exec chown root:root {} \;
find /root/data/ -maxdepth 1 -type d -exec chmod 777 {} \;