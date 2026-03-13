# INSPIRARE - Landing Page

> Responsive landing page for INSPIRARE S.A.S. — a nearshore software development agency targeting US/Canada clients. Built with Flutter Web, hosted on Firebase Hosting.

## Quick Info
| Field | Value |
|-------|-------|
| Package | `inspirare` |
| Framework | Flutter Web |
| Language | Bilingual EN/ES via InheritedWidget (manual l10n) |
| i18n URL | `?lang=es` for Spanish, default English |
| Status | In production |
| Backend | None (static landing) |
| Breakpoints | Mobile: 768px, Desktop: 1024px |
| Target Market | US & Canada (nearshore software development) |

## Build & Run

```bash
flutter pub get
flutter run -d chrome
flutter build web
flutter analyze
flutter test
```

## Sections (10 total)

1. **Hero** — Headline, CTAs ("Get Your Free Estimate" + "See Our Work"), metrics bar
2. **Services** — 6 service cards (Web Apps, Mobile, MVP, AI/ML, Cloud, UI/UX)
3. **Why INSPIRARE** — 6 nearshore advantage cards + tech stack ribbon
4. **Portfolio** — 4 case study cards (Challenge → Solution → Results)
5. **Process** — 5-step timeline (Discovery → Design → Develop → Deploy → Support)
6. **Pricing** — 3 engagement models (Fixed-Price, Time & Materials, Dedicated Team)
7. **FAQ** — 6 expandable Q&A items
8. **Contact/CTA** — Contact form + info (mailto-based submission)
9. **Footer** — Brand, Services, Company, Contact columns

## Key Files

| File | Purpose |
|------|---------|
| `lib/theme/web_theme.dart` | Palette, Fonts, Breakpoints, AppTransitions |
| `lib/core/constants/app_constants.dart` | NavSection enum, AppUrls |
| `lib/core/l10n/app_strings.dart` | Abstract class with all translatable string keys |
| `lib/core/l10n/strings_en.dart` | English string implementations |
| `lib/core/l10n/strings_es.dart` | Spanish string implementations |
| `lib/core/l10n/locale_provider.dart` | LocaleScope + LocaleProvider (InheritedWidget) |
| `lib/widgets/common/language_toggle.dart` | EN/ES toggle widget for navbar |
| `lib/pages/landing_page.dart` | LayoutBuilder responsive switch |
| `lib/pages/landing/desktop_layout.dart` | Desktop layout with 10 sections |
| `lib/pages/landing/mobile_layout.dart` | Mobile layout with 10 sections |
| `lib/pages/landing/scroll_navigation_mixin.dart` | Scroll-to-section logic |
| `lib/widgets/common/glassmorphism_nav.dart` | Fixed navbar with glass effect |
| `lib/widgets/common/animated_section.dart` | Fade-up animation on scroll |
| `lib/widgets/common/section_header.dart` | Reusable section header |
| `lib/widgets/sections/*.dart` | 8 section widgets |
| `web/index.html` | SEO meta tags, Schema.org, Open Graph |

## Contexto Modular

```
.claude/context/
├── domain.md           # Business, products, terminology
├── architecture.md     # Technical structure, patterns, dependencies
├── firestore.md        # Current state (no backend)
└── features/
    └── landing.md      # Sections, components, navigation
```

---
*Agents load specific context automatically from `.claude/context/`*
