# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Inspirare is a Flutter web/mobile landing page for INSPIRARE S.A.S., a Salvadoran SaaS company with two products: Factura Facil DTE (electronic invoicing) and ContaSAS.ia (AI-powered accounting). The project uses responsive design with breakpoints at 768px (mobile) and 1024px (tablet/desktop).

## Build & Run Commands

```bash
# Get dependencies
flutter pub get

# Run in development (web)
flutter run -d chrome

# Run on specific device
flutter run -d <device_id>

# Build for web production
flutter build web

# Analyze code
flutter analyze

# Run tests
flutter test
```

## Architecture

### Responsive Layout Pattern
The app uses `LayoutBuilder` in `LandingPage` to switch between layouts:
- `HeroSectionWeb` (desktop_layout.dart) - for screens >768px width
- `MobileLayout` (mobile_layout.dart) - for screens <=768px width

Both layouts share the same sections with `isMobile` parameter, and use a `GlassmorphismNav` fixed at top.

### Directory Structure
```
lib/
├── main.dart              # App entry point
├── theme/
│   └── web_theme.dart     # Palette, Fonts, Breakpoints, AppTransitions
├── pages/
│   ├── landing_page.dart  # Responsive layout switcher
│   └── landing/
│       ├── desktop_layout.dart  # Desktop layout with scroll navigation
│       └── mobile_layout.dart   # Mobile layout with scroll navigation
└── widgets/
    ├── common/
    │   ├── animated_section.dart  # Fade-up animation on scroll visibility
    │   ├── glassmorphism_nav.dart # Fixed nav with backdrop blur
    │   └── section_header.dart    # Reusable section headers
    └── sections/
        ├── hero_section.dart      # Badge, headline, buttons, metrics bar
        ├── products_section.dart  # DTE and ContaSAS product cards with mockups
        ├── why_section.dart       # Dark section with 6 benefit cards + tech ribbon
        ├── pricing_section.dart   # Two pricing cards
        ├── cta_section.dart       # Call-to-action with WhatsApp/email buttons
        └── footer_section.dart    # 4-column footer with legal info
```

### Theme System
Defined in `lib/theme/web_theme.dart`:
- `Palette` class: `primary` (#75CCCC), `dark` (#212630), `background` (#FFF9F5), product colors (dtePrimary, contasasPrimary), text colors
- `Fonts` class: `brand` (PlayfairDisplay-BlackItalic), `title` (PlayfairDisplay-ExtraBold), `body` (Roboto-Medium), `about` (PlayfairDisplay-Regular)
- `Breakpoints` class: `mobile` (768), `tablet`/`desktop` (1024)
- `AppTransitions` class: animation curves and durations

### Design Patterns
- **Glassmorphism Nav**: Fixed top navigation with `BackdropFilter` blur, scroll-responsive opacity
- **Hover Effects**: Cards and buttons use `MouseRegion` + `AnimatedContainer` for translateY and shadow transitions
- **Section Animation**: `AnimatedSection` widget uses `VisibilityDetector` to trigger fade-up on scroll
- **Responsive Grid**: Sections detect screen width via `MediaQuery` and switch between column/row layouts

## Key Dependencies

- `font_awesome_flutter` - Icons
- `url_launcher` - External links (WhatsApp, email, product URLs)
- `visibility_detector` - Scroll-triggered animations
- `flutter_lints` - Static analysis rules
