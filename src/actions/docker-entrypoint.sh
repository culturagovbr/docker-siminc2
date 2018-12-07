#!/bin/bash
set -e
echo "[ ****************** ] Starting Endpoint of Application"
if ! [ -d "/var/www/siminc2" ] || ! [ -d "/var/www/siminc2/includes" ]; then
    echo "Application not found in /var/www/siminc2 - cloning now..."
    if [ "$(ls -A /var/www/siminc2)" ]; then
        echo "WARNING: /var/www/siminc2 is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 5 )
    fi
    echo "[ ****************** ] Cloning Project repository to tmp folder"
    git clone https://github.com/culturagovbr/siminc2 /tmp/siminc2
    ls -la /tmp/siminc2

    echo "[ ****************** ] Copying Project from temporary folder to workdir"
    cp /tmp/siminc2 -R /var/www/

    chown www-data:1000 -R /var/www/siminc2
    ls -la /var/www/siminc2

    echo "[ ****************** ] Complete! The application has been successfully copied to /var/www/siminc2"

    cd /var/www/siminc2
fi

if  ! [ -e "/var/www/siminc2/global/config.inc" ] ; then

    echo "[ ****************** ] Copying sample application configuration to real one"
    cp /var/www/siminc2/global/config-exemplo.inc /var/www/siminc2/global/config.inc
    cp /var/www/siminc2/global/database-exemplo.php /var/www/siminc2/global/database.php
    chown www-data:1000 -R /var/www/siminc2/global
    ls -la /var/www/siminc2/global

    echo "[ ****************** ] Show database configuration! To modify configuration: $ vim siminc2/global/database.php"
    cat /var/www/siminc2/global/database.php
fi

echo "[ ****************** ] Ending Endpoint of Application"
exec "$@"
