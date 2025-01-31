# Script de Instalación Completa de WordPress en Linux

Este script automatiza la instalación y configuración de WordPress en un servidor Linux (distribuciones basadas en Debian/Ubuntu). Incluye la instalación de dependencias (Apache, MySQL, PHP), la configuración de la base de datos, la descarga de WordPress y la configuración del archivo `wp-config.php`.

---

## **Requisitos**

- Un servidor Linux con una distribución basada en Debian/Ubuntu.
- Acceso de superusuario (root) o capacidad para ejecutar comandos con `sudo`.
- Un dominio o dirección IP para acceder al sitio WordPress.
--- 
## **Instrucciones de Uso**

### 1. **Guardar el Script**

Copia el siguiente contenido en un archivo, por ejemplo, `install_wordpress.sh`:
---
### 2. **Hacer Ejecutable el Script**

Ejecuta el siguiente comando para dar permisos de ejecución al script:
bash
Copy

chmod +x install_wordpress.sh
---
### 3. **Ejecutar el Script**

Ejecuta el script como superusuario (root):
bash
Copy

sudo ./install_wordpress.sh
---
### 4. **Acceder al Sitio WordPress**

Una vez que el script termine, accede a tu sitio WordPress en la URL que configuraste (por ejemplo, http://tudominio.com).

    Usuario administrador: El que configuraste en la variable WP_ADMIN_USER.

    Contraseña administrador: La que configuraste en la variable WP_ADMIN_PASS.

Personalización del Script

Puedes modificar las siguientes variables en el script para adaptarlo a tus necesidades:

    DB_NAME: Nombre de la base de datos.

    DB_USER: Usuario de la base de datos.

    DB_PASS: Contraseña de la base de datos.

    WP_URL: URL del sitio WordPress.

    WP_TITLE: Título del sitio.

    WP_ADMIN_USER: Usuario administrador de WordPress.

    WP_ADMIN_PASS: Contraseña del administrador.

    WP_ADMIN_EMAIL: Correo del administrador.

## Notas Adicionales

    Dominio y DNS: Asegúrate de que el dominio que configures (tudominio.com) apunte a la IP de tu servidor.

    Certificado SSL: Si deseas agregar HTTPS, puedes usar Let's Encrypt para generar un certificado SSL.

    Firewall: Configura un firewall (como UFW) para proteger tu servidor.

    Backups: Configura un sistema de backups para tu base de datos y archivos de WordPress.

---
### **Cómo Usar el Archivo README.md**

1. **Crea un Archivo Nuevo**:
   - Abre un editor de texto (como Notepad, Visual Studio Code, Sublime Text, o incluso `nano` en la terminal).
   - Copia y pega el contenido anterior en el archivo.

2. **Guarda el Archivo**:
   - Guarda el archivo con el nombre `README.md` en la misma carpeta donde tienes el script `install_wordpress.sh`.

3. **Verifica el Archivo**:
   - Asegúrate de que el archivo `README.md` esté en la misma carpeta que el script. Por ejemplo:
     ```
     /ruta/a/tu/carpeta/
     ├── install_wordpress.sh
     └── README.md
     ```

4. **Úsalo como Documentación**:
   - Ahora tienes un archivo `README.md` bien documentado que explica cómo usar el script.

---