# Inspirare - Landing Page

> Landing page responsiva de INSPIRARE S.A.S. para productos SaaS de facturacion electronica (DTE) y contabilidad IA.

## Quick Info
| Campo | Valor |
|-------|-------|
| Package | `inspirare` |
| Framework | Flutter Web |
| Estado | En produccion |
| Backend | Ninguno (landing estatica) |
| Breakpoints | Mobile: 768px, Desktop: 1024px |

## Build & Run

```bash
flutter pub get
flutter run -d chrome
flutter build web
flutter analyze
flutter test
```

## Contexto Modular

```
.claude/context/
├── domain.md           # Negocio, productos, terminologia DTE
├── architecture.md     # Estructura tecnica, patrones, dependencias
├── firestore.md        # Estado actual (sin backend)
└── features/
    └── landing.md      # Secciones, componentes, navegacion
```

## Modulos

- [x] Landing Page - `.claude/context/features/landing.md`

## Archivos Clave

| Archivo | Proposito |
|---------|-----------|
| `lib/theme/web_theme.dart` | Palette, Fonts, Breakpoints, AppTransitions |
| `lib/pages/landing_page.dart` | LayoutBuilder responsive |
| `lib/pages/landing/desktop_layout.dart` | Layout desktop con scroll |
| `lib/pages/landing/mobile_layout.dart` | Layout mobile con scroll |
| `lib/widgets/common/glassmorphism_nav.dart` | Navbar con efecto vidrio |
| `lib/widgets/sections/*.dart` | 6 secciones de la landing |

---
*Los agentes cargan contexto especifico automaticamente desde `.claude/context/`*
