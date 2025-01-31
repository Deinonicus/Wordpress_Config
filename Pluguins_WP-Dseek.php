<?php
/**
 * Plugin Name: Instalador de Plugins Esenciales
 * Description: Script para instalar y activar plugins esenciales en WordPress.
 * Version: 1.0
 * Author: Tu Nombre
 */

// Función para instalar y activar plugins
function instalar_plugins_esenciales() {
    // Lista de plugins a instalar y activar
    $plugins = array(
        'woocommerce' => 'https://downloads.wordpress.org/plugin/woocommerce.latest-stable.zip',
        'translatepress-multilingual' => 'https://downloads.wordpress.org/plugin/translatepress-multilingual.latest-stable.zip',
        'sitepress-multilingual-cms' => 'https://downloads.wordpress.org/plugin/sitepress-multilingual-cms.latest-stable.zip', // WPML
        'wordpress-seo' => 'https://downloads.wordpress.org/plugin/wordpress-seo.latest-stable.zip',
        'woocommerce-subscriptions' => 'https://downloads.wordpress.org/plugin/woocommerce-subscriptions.latest-stable.zip',
        'elementor' => 'https://downloads.wordpress.org/plugin/elementor.latest-stable.zip',
        'tawkto-live-chat' => 'https://downloads.wordpress.org/plugin/tawkto-live-chat.latest-stable.zip',
        'wp-smushit' => 'https://downloads.wordpress.org/plugin/wp-smushit.latest-stable.zip', // Smush
        'litespeed-cache' => 'https://downloads.wordpress.org/plugin/litespeed-cache.latest-stable.zip',
    );

    // Verifica si las funciones necesarias están disponibles
    if (!function_exists('request_filesystem_credentials') || !function_exists('WP_Filesystem') || !function_exists('activate_plugin')) {
        require_once ABSPATH . 'wp-admin/includes/file.php';
        require_once ABSPATH . 'wp-admin/includes/plugin-install.php';
        require_once ABSPATH . 'wp-admin/includes/class-wp-upgrader.php';
        require_once ABSPATH . 'wp-admin/includes/plugin.php';
    }

    // Inicializa el sistema de archivos de WordPress
    WP_Filesystem();

    // Instala y activa cada plugin
    foreach ($plugins as $slug => $url) {
        $plugin_path = $slug . '/' . $slug . '.php';

        // Verifica si el plugin ya está instalado y activo
        if (!is_plugin_active($plugin_path)) {
            // Verifica si el plugin ya está instalado pero inactivo
            if (!file_exists(WP_PLUGIN_DIR . '/' . $plugin_path)) {
                // Instala el plugin
                $upgrader = new Plugin_Upgrader(new Automatic_Upgrader_Skin());
                $upgrader->install($url);
            }

            // Activa el plugin
            activate_plugin($plugin_path);
        }
    }
}

// Ejecuta la función al activar el plugin
register_activation_hook(__FILE__, 'instalar_plugins_esenciales');
?>