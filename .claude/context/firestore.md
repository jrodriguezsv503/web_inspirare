# Firestore - Inspirare Landing Page

## Estado Actual

**No hay integracion con Firebase/Firestore.**

Este proyecto es una landing page estatica sin backend. No hay:
- Paquetes de Firebase en pubspec.yaml
- Colecciones de Firestore
- Security Rules
- Cloud Functions

## Integracion Futura (Potencial)

Cuando se integre Firebase, considerar:

### Colecciones Candidatas
- `leads/` - Formularios de contacto desde la landing
- `analytics/` - Eventos de la landing (opcional, Google Analytics puede cubrir esto)

### Servicios Firebase Candidatos
- **Hosting**: Deploy de la landing page
- **Analytics**: Tracking de conversiones
- **Firestore**: Solo si se agrega formulario de contacto

## Notas
- El contacto actual es via WhatsApp y email (links externos)
- No hay formularios que requieran backend
