#!/bin/bash

## IMPORTANTE!!!
## Sustituye las direcciones y dominios de ejemplo con tus propios direcciones de correos y dominios  ########

# Actualizar el sistema
echo "Actualizando el sistema..."
apt update && apt upgrade -y

# Instalar Apache
echo "Instalando Apache..."
apt install apache2 -y
systemctl enable apache2
systemctl start apache2

# Instalar MySQL
echo "Instalando MySQL..."
apt install mysql-server -y
systemctl enable mysql
systemctl start mysql

# Configurar MySQL
echo "Configurando MySQL..."
mysql_secure_installation <<EOF

y
n
y
y
y
y
EOF

# Crear base de datos para WordPress
echo "Creando base de datos para WordPress..."
mysql -uroot -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -uroot -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wp_password';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';"
mysql -uroot -e "FLUSH PRIVILEGES;"

# Instalar PHP y extensiones
echo "Instalando PHP y extensiones necesarias..."
apt install php php-mysql php-curl php-gd php-mbstring php-xml php-zip libapache2-mod-php -y

# Descargar y configurar WordPress
echo "Descargando WordPress..."
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
cp -r wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Configurar archivo wp-config.php
echo "Configurando WordPress..."
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/wordpress/" /var/www/html/wp-config.php
sed -i "s/username_here/wpuser/" /var/www/html/wp-config.php
sed -i "s/password_here/wp_password/" /var/www/html/wp-config.php

# Configurar Apache Virtual Host
echo "Configurando Virtual Host..."
cat <<EOL > /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
    ServerAdmin admin@tudominio.com
    DocumentRoot /var/www/html
    ServerName tudominio.com
    ServerAlias www.tudominio.com

    <Directory /var/www/html/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

a2ensite wordpress
a2enmod rewrite
systemctl restart apache2

# Configurar Firewall
echo "Configurando el firewall..."
ufw allow OpenSSH
ufw allow 'Apache Full'
ufw --force enable

# Mensaje final
echo "Instalación completa. Accede a tu sitio en: http://tudominio.com"
