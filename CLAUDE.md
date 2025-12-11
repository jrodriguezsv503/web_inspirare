# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Inspirare is a Flutter web/mobile landing page for a digital agency. The project uses responsive design with separate layouts for desktop (>700px) and mobile viewports.

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
- `HeroSectionWeb` (desktop_layout.dart) - for screens >700px width
- `MobileLayout` (mobile_layout.dart) - for screens ≤700px width

### Directory Structure
```
lib/
├── main.dart              # App entry point
├── theme/
│   └── web_theme.dart     # Palette colors and font families
├── pages/
│   ├── landing_page.dart  # Responsive layout switcher
│   └── landing/
│       ├── desktop_layout.dart
│       └── mobile_layout.dart
└── widgets/
    ├── cards_desktop.dart # Desktop popup content widgets
    └── cards_movil.dart   # Mobile popup content widgets
```

### Theme System
Defined in `lib/theme/web_theme.dart`:
- `Palette` class: `primary` (cyan #08C4D4), `dark` (#212630), `background` (#FFF9F5)
- `Fonts` class: `brand` (PlayfairDisplay-BlackItalic), `title` (PlayfairDisplay-ExtraBold), `body` (Roboto-Medium), `about` (PlayfairDisplay-Regular)

### Overlay Popup Pattern
Both layouts use custom overlay-based popups (not dialogs) via `Overlay.of(context).insert()`. The popup content is displayed with a semi-transparent background that dismisses on tap.

## Key Dependencies

- `font_awesome_flutter` - Icons (used for WhatsApp icon)
- `url_launcher` - External links (WhatsApp, email)
- `flutter_lints` - Static analysis rules
