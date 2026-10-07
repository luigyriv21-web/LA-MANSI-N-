# LA MANSIÓN 10.10

**Una casa para todas las historias.**

LA MANSIÓN es una comunidad creativa construida alrededor de la metáfora de una mansión: cada persona tiene una habitación, las historias viven en la Biblioteca, el arte en la Galería, las conversaciones en la Sala de Estar y las comunidades en los Círculos.

## Incluido en 10.10

- PWA instalable y responsive.
- Ritual de la Llave y personalización de habitación.
- Casa, Pasillo, Biblioteca, Galería, Comunidad, Atelier, Salones, Buzón, Mayordomo y Cuenta.
- Registro, login, logout y sesiones.
- API Node.js.
- PostgreSQL para producción.
- Fallback local para demostraciones sin base de datos.
- Historias y capítulos.
- Posts, círculos y miembros.
- Seguimientos, admiraciones y comentarios.
- Mensajería y notificaciones.
- Reportes para moderación.
- Rate limiting y cabeceras básicas de seguridad.
- Docker + Docker Compose.
- Capacitor preparado para Android/iOS.

## Desarrollo

```bash
npm install
npm start
```

Abre `http://localhost:8787`.

Para producción, configura `DATABASE_URL` con PostgreSQL y ejecuta `database/schema.sql`.

También puedes levantar todo con:

```bash
docker compose up --build
```

## App móvil

```bash
npm install
npm run cap:sync
npm run cap:android
npm run cap:ios
```

Las cuentas de Google Play / Apple Developer, certificados, dominio, almacenamiento de medios, correo transaccional y claves de producción deben ser creados por el propietario del producto.

## Estado

Este paquete es una **base de producción preparada para despliegue**, no una publicación automática en tiendas. Las dependencias se instalan con `npm install`; el entorno de ejecución debe disponer de Node 20+ y, para producción, PostgreSQL.
