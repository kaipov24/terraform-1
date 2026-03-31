#!/bin/bash
yum update -y
yum install -y httpd

cat > /var/www/html/index.html <<'HTML'
<h1>Blue Environment</h1>
HTML

systemctl enable httpd
systemctl restart httpd