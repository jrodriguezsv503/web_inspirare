# Feature: Landing Page

## Descripcion
Pagina de aterrizaje responsiva para INSPIRARE S.A.S. que presenta los productos DTE y ContaSAS.ia, beneficios, precios y opciones de contacto.

## Estado de Implementacion
| Capa | Estado |
|------|--------|
| Presentation | Completa |
| Domain | N/A (sin logica de negocio) |
| Data | N/A (sin backend) |
| Tests | Pendiente |

## Secciones de la Landing

### 1. Hero Section (`hero_section.dart`)
- Badge animado con texto destacado
- Headline principal y subtitulo
- Botones CTA (WhatsApp, ver productos)
- Barra de metricas (clientes, DTEs, uptime)

### 2. Products Section (`products_section.dart`)
- Card de Factura Facil DTE con mockup
- Card de ContaSAS.ia con mockup
- Links a cada producto
- Colores diferenciados por producto (dtePrimary, contasasPrimary)

### 3. Why Section (`why_section.dart`)
- Seccion con fondo oscuro
- 6 cards de beneficios con iconos
- Ribbon de tecnologias (Flutter, Firebase, Cloud, etc.)
- Hover effects en cards

### 4. Pricing Section (`pricing_section.dart`)
- Card plan DTE con precio y features
- Card plan ContaSAS.ia con precio y features
- Botones de contratacion

### 5. CTA Section (`cta_section.dart`)
- Call-to-action final
- Boton WhatsApp
- Boton email
- Mensaje persuasivo

### 6. Footer Section (`footer_section.dart`)
- 4 columnas: empresa, productos, legal, contacto
- Info legal (NIT, registro comercial)
- Links a redes sociales
- Copyright

## Componentes Compartidos

### GlassmorphismNav (`glassmorphism_nav.dart`)
- Navbar fijo con efecto glassmorphism
- Links de navegacion a secciones
- Responsive: hamburger menu en mobile
- Opacidad reactiva al scroll

### AnimatedSection (`animated_section.dart`)
- Wrapper que anima children al aparecer en viewport
- Usa VisibilityDetector
- Fade-up con duration configurable

### SectionHeader (`section_header.dart`)
- Titulo + subtitulo reutilizable
- Estilos consistentes entre secciones

## Navegacion
- Single page con scroll suave entre secciones
- `ScrollNavigationMixin` maneja scroll programatico
- `GlobalKey` por seccion para posicionamiento
- No usa go_router (no hay multiples paginas)

## Reglas de UI
- Breakpoint mobile: 768px
- Breakpoint desktop: 1024px
- Colores por producto: DTE (#4CAF50 area), ContaSAS (#2196F3 area)
- Fuente brand: PlayfairDisplay, body: Roboto
- Efecto glassmorphism en nav con BackdropFilter
