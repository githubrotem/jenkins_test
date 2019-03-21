#!/bin/sh

echo "Setting SSH"
sed -i s/"PermitRootLogin no"/"PermitRootLogin yes"/g /etc/ssh/sshd_config
sed -i s/"#PubkeyAuthentication yes"/"PubkeyAuthentication yes"/g /etc/ssh/sshd_config
sed -i s/"GSSAPIAuthentication yes"/"GSSAPIAuthentication no"/g /etc/ssh/sshd_config

echo "Installing Apache"
/usr/bin/yum install -y httpd
/usr/bin/systemctl start httpd
/usr/bin/systemctl enable httpd

echo "Setting Custom index.html"
chmod +x /etc/rc.d/rc.local
systemctl enable rc-local
echo 'cat <<EOF> /var/www/html/index.html
<html>
 <head>
  <title>Web Service - `hostname`</title>
 </head>
 <body>
  <h1>HELLO - This is `hostname`</h1>
  <h1>I am the CAPTAIN of the world !!!</h1>
 </body>
</html>
EOF' >>  /etc/rc.d/rc.local

