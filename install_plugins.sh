#!/bin/bash

# Define variables
WP_PATH="/var/www/html" # Ruta donde está instalado WordPress

# Verifica si wp-cli está disponible
if ! command -v wp &> /dev/null
then
    echo "wp-cli no está instalado. Por favor, instálalo antes de ejecutar este script."
    exit
fi

# Cambiar al directorio de WordPress
cd $WP_PATH

# Lista de plugins a instalar
PLUGINS=(
    "woocommerce" # Tienda
    "translatepress-multilingual" # Traducción
    "wpml" # Alternativa para traducción
    "wordpress-seo" # SEO (Yoast)
    "woocommerce-subscriptions" # WooCommerce Subscriptions
    "elementor" # Constructor visual
    "tawkto-live-chat" # Chat en vivo
    "smush" # Optimización de imágenes
    "litespeed-cache" # Cache (si se usa LiteSpeed)
)

echo "Instalando y activando plugins necesarios..."

# Instalar y activar cada plugin
for PLUGIN in "${PLUGINS[@]}"
do
    echo "Instalando $PLUGIN..."
    wp plugin install $PLUGIN --activate
done

# Instalar y activar plugins premium (manual o por ZIP si es necesario)
# Puedes descargar manualmente los ZIP y añadirlos aquí
PREMIUM_PLUGINS=(
    "/path/to/wpml.zip"
    "/path/to/woocommerce-subscriptions.zip"
)

for ZIP in "${PREMIUM_PLUGINS[@]}"
do
    echo "Instalando plugin premium desde $ZIP..."
    wp plugin install $ZIP --activate
done

echo "Todos los plugins han sido instalados y activados."
