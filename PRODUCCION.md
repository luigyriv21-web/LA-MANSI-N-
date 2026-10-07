# LA MANSIÓN 10.10 — Producción

## Qué está listo
- PWA instalable con manifest y service worker.
- Backend Node.js con autenticación por sesión Bearer.
- PostgreSQL schema completo.
- Usuarios, habitaciones, historias, capítulos, círculos, miembros, posts, follows, likes, comentarios, mensajes, notificaciones y reportes.
- Rate limiting básico y cabeceras HTTP de seguridad.
- Dockerfile + docker-compose para levantar app y PostgreSQL.
- Capacitor preparado para Android/iOS.

## Arranque local
1. Instalar Node 20+.
2. `npm install`
3. Copiar `.env.example` a `.env` y definir `DATABASE_URL`, o arrancar con `docker compose up --build`.
4. Abrir `http://localhost:8787`.
5. Health: `GET /api/health`.

## Android / iOS
Ejecutar `npm run cap:sync` después de instalar Capacitor CLI. Abrir los proyectos nativos con `npm run cap:android` o `npm run cap:ios`.
Antes de publicar, configurar iconos/splash, bundle IDs, certificados, privacy manifest y cuentas de las tiendas.

## Producción real
- Usar PostgreSQL administrado.
- Usar almacenamiento de objetos (S3/R2/etc.) para portadas, imágenes y audio; no guardar medios grandes en PostgreSQL.
- Poner HTTPS delante del servidor.
- Definir `APP_ORIGIN` con el dominio real.
- Rotar credenciales y secretos.
- Configurar backups de PostgreSQL.
- Añadir proveedor de correo para recuperación de contraseña/verificación.
- Añadir proveedor push para notificaciones móviles.
- Configurar moderadores y política de reportes.
- Configurar analítica respetuosa con la privacidad.

## Límites honestos
Este repositorio no puede crear por sí solo cuentas de Apple/Google, servidores cloud, dominio, claves de firma, proveedores de almacenamiento o servicios de correo. Esos recursos deben ser creados por el propietario del producto y sus secretos deben introducirse como variables de entorno.
