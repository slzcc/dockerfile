#!/bin/bash

test -f /etc/users.list || exit 0

while read id username hash groups; do
        # Skip, if user already exists
        grep ^$username /etc/passwd && continue
        # Create group
        addgroup --gid $id $username
        # Create user
        useradd -m -u $id -s /bin/bash -g $username $username
        # Set password
        echo "$username:$hash" | /usr/sbin/chpasswd -e
        # Add supplemental groups
        if [ $groups ]; then
                usermod -aG $groups $username
        fi
        sed -i "27i $username  ALL=(ALL) NOPASSWD:ALL" /etc/sudoers
done < /etc/users.list
