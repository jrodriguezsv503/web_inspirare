# Arquitectura - Inspirare Landing Page

## Tipo de Proyecto
Landing page estatica (sin backend) construida con Flutter Web.

## Estructura de Carpetas

```
lib/
├── main.dart                          # Entry point, MaterialApp
├── core/
│   ├── constants/app_constants.dart   # URLs, textos, constantes globales
│   └── utils/url_launcher_helper.dart # Helper para abrir URLs externas
├── theme/
│   └── web_theme.dart                 # Palette, Fonts, Breakpoints, AppTransitions
├── pages/
│   ├── landing_page.dart              # LayoutBuilder: desktop vs mobile
│   └── landing/
│       ├── desktop_layout.dart        # Layout desktop con scroll navigation
│       ├── mobile_layout.dart         # Layout mobile con scroll navigation
│       └── scroll_navigation_mixin.dart # Mixin compartido para scroll
└── widgets/
    ├── common/
    │   ├── animated_section.dart      # Animacion fade-up al hacer scroll
    │   ├── glassmorphism_nav.dart     # Navbar fijo con blur de vidrio
    │   └── section_header.dart        # Headers reutilizables de seccion
    └── sections/
        ├── hero_section.dart          # Hero con badge, headline, metricas
        ├── products_section.dart      # Cards de DTE y ContaSAS
        ├── why_section.dart           # Seccion oscura con beneficios
        ├── pricing_section.dart       # Cards de precios
        ├── cta_section.dart           # Call-to-action WhatsApp/email
        └── footer_section.dart        # Footer 4 columnas
```

## Patrones Utilizados

### Responsive Layout
- `LayoutBuilder` en `LandingPage` detecta ancho de pantalla
- Breakpoint mobile: 768px
- Breakpoint desktop: 1024px
- Parametro `isMobile` propagado a todas las secciones

### Scroll Navigation
- `ScrollNavigationMixin` compartido entre desktop y mobile layouts
- `GlobalKey` por seccion para scroll programatico
- `GlassmorphismNav` fijo en top con blur y opacidad reactiva al scroll

### Animaciones
- `AnimatedSection`: usa `VisibilityDetector` para trigger fade-up
- Hover effects: `MouseRegion` + `AnimatedContainer` para translateY y sombras
- Transiciones definidas en `AppTransitions` del theme

### Theme System
- `Palette`: colores primarios (#75CCCC), dark (#212630), background (#FFF9F5)
- `Fonts`: PlayfairDisplay (brand/titulos), Roboto (body)
- Fuentes cargadas como assets locales (no Google Fonts CDN)

## Dependencias Clave
| Paquete | Uso |
|---------|-----|
| font_awesome_flutter | Iconos de redes y UI |
| url_launcher | Links externos (WhatsApp, email, productos) |
| visibility_detector | Animaciones al scroll |
| flutter_lints | Analisis estatico |

## Estado Actual
- NO usa Firebase/backend
- NO usa state management (Riverpod/BLoC)
- NO usa go_router (single page)
- NO tiene features/ (no es Clean Architecture aun)
- NO tiene tests implementados

## Convenciones de Archivos
- `snake_case` para nombres de archivos
- Secciones de la landing son widgets independientes en `widgets/sections/`
- Componentes reutilizables en `widgets/common/`
- Un archivo por widget principal
