#!/bin/bash

# Script de instalación completa de WordPress en un servidor Linux
# Autor: Tu Nombre
# Versión: 1.0

# Variables configurables
DB_NAME="wordpress_db"          # Nombre de la base de datos
DB_USER="wordpress_user"        # Usuario de la base de datos
DB_PASS="SecurePassword123"     # Contraseña de la base de datos
WP_URL="tudominio.com"          # URL del sitio WordPress
WP_TITLE="Mi Sitio WordPress"   # Título del sitio
WP_ADMIN_USER="admin"           # Usuario administrador de WordPress
WP_ADMIN_PASS="AdminPassword123" # Contraseña del administrador
WP_ADMIN_EMAIL="admin@tudominio.com" # Correo del administrador

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo apt update && sudo apt upgrade -y

# Instalar dependencias (Apache, MySQL, PHP, y extensiones necesarias)
echo "Instalando dependencias..."
sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

# Habilitar Apache y MySQL en el inicio
sudo systemctl enable apache2
sudo systemctl enable mysql

# Configurar MySQL
echo "Configurando MySQL..."
sudo mysql -e "CREATE DATABASE ${DB_NAME};"
sudo mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Descargar WordPress
echo "Descargando WordPress..."
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
sudo mv wordpress /var/www/html/

# Configurar permisos
echo "Configurando permisos..."
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

# Crear el archivo wp-config.php
echo "Configurando wp-config.php..."
cd /var/www/html/wordpress
sudo cp wp-config-sample.php wp-config.php
sudo sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
sudo sed -i "s/username_here/${DB_USER}/" wp-config.php
sudo sed -i "s/password_here/${DB_PASS}/" wp-config.php

# Generar claves de seguridad
SALT=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
sudo sed -i "/AUTH_KEY/s/put your unique phrase here/${SALT}/" wp-config.php

# Configurar Apache para WordPress
echo "Configurando Apache..."
sudo tee /etc/apache2/sites-available/wordpress.conf > /dev/null <<EOL
<VirtualHost *:80>
    ServerAdmin webmaster@${WP_URL}
    DocumentRoot /var/www/html/wordpress
    ServerName ${WP_URL}
    ServerAlias www.${WP_URL}

    <Directory /var/www/html/wordpress/>
        AllowOverride All
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Habilitar el sitio y reiniciar Apache
sudo a2ensite wordpress.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

# Instalar WordPress CLI (opcional pero útil)
echo "Instalando WP-CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Configurar WordPress usando WP-CLI
echo "Configurando WordPress..."
cd /var/www/html/wordpress
sudo -u www-data wp core install --url=${WP_URL} --title="${WP_TITLE}" --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_EMAIL}

# Mostrar mensaje de finalización
echo "¡Instalación completada!"
echo "Accede a tu sitio WordPress en: http://${WP_URL}"
echo "Usuario administrador: ${WP_ADMIN_USER}"
echo "Contraseña administrador: ${WP_ADMIN_PASS}"