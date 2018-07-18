
echo "[******] Copying and enable virtualhost 'site.conf'";
cp /tmp/src/actions/virtual-host/site.conf /etc/apache2/sites-available/site.conf

a2ensite site.conf

echo "[******] Disable default virtualhost '000-default.conf'";
a2dissite 000-default.conf

echo "[******] Enable Apache Mod Rewrite";
a2enmod rewrite

echo "[******] Enable Apache Mod Headers";
a2enmod headers

echo "[******] Restarting Apache 2 Service";
service apache2 reload

echo "[******] Starts Apache using Foreground Mode";
apache2ctl -D FOREGROUND