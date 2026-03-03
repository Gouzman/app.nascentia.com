# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter **web** landing page for the NASCENTIA mobile app. The site is a single-page marketing site with smooth-scroll navigation between sections.


## Commands

```bash
# Install dependencies
flutter pub get

# Run in development (Chrome)
flutter run -d chrome

# Build for production (output: build/web/)
flutter build web

# Analyze code
flutter analyze

# Run tests
flutter test
```

## Architecture

### Entry Point & Routing

`lib/main.dart` → `lib/app.dart` sets up `MaterialApp` with two named routes:
- `/` → `HomePage`
- `/download` → `DownloadPage`

### Page Structure

`HomePage` is a `SingleChildScrollView` containing a `TopNavigationBar` followed by all page sections in order. Each section is wrapped with a `GlobalKey` from `NavigationService` to enable smooth-scroll anchor navigation. Mobile users get a `Drawer` with the same nav items.

### Section Ordering (lib/sections/)

`HeroSection` → `PersonalizedSupportSection` → `FastOrderSection` → `AboutSection` → `CredibilitySection` → `FeaturesSection` → `HowItWorksSection` → `CalendarSection` → `AppSection` → `AppFooter` (contact)

### Navigation Service (`lib/services/navigation_service.dart`)

Holds static `GlobalKey` instances for each section. `scrollToSection(key)` calls `Scrollable.ensureVisible()` with a 500ms easeInOut animation. The `sections` map defines which nav items are exposed in the top bar and mobile drawer.

### Design System (`lib/theme/`)

Always use these — never define styles inline:

- **`AppColors`** — all colors and gradients. Primary brand palette: rose `#E95263` + violet `#582674`. Use `.withValues(alpha:)` (not `.withOpacity()`) for transparency.
- **`AppTextStyles`** — responsive text styles, all methods take `BuildContext`. Use `.copyWith()` to override specific properties. Never use raw `TextStyle()` or hardcode `fontSize`.
- **`AppConstants`** — spacing (multiples of 4/8px), border radii, breakpoints, animation durations, and shadow presets.

### Reusable Widgets (`lib/widgets/`)

- `SectionContainer` — wraps section content with responsive horizontal padding and constrains max width to 1200px.
- `PrimaryButton` — branded button with gradient and hover animation.
- `GradientBackground` — full-width gradient wrapper.
- `PhoneMockup` — phone frame widget for screenshots.
- `FeatureCardModern` — card with gradient background for feature lists.
- `TopNavigationBar` — floating pill-style nav with responsive desktop/tablet/mobile layouts.
- `AppFooter` — dark footer, also serves as the Contact section.

### Responsive Breakpoints

```dart
mobile:  < 768px   (AppConstants.breakpointMobile)
tablet:  768–1024px
desktop: > 1024px  (AppConstants.breakpointDesktop = 1440px)
maxContentWidth: 1200px
```

### Assets

Phone mockup images go in `assets/images/` (referenced as `assets/images/phone_1.png`, etc.).

## Key Conventions


- All sections are `StatelessWidget` unless they need animation state.
- Hover interactions use `MouseRegion` + `GestureDetector` (not `InkWell`) to maintain custom visual control.
- Buttons use `Builder` to access the nearest `BuildContext` for `Navigator.pushNamed`.
- Color aliases exist in `AppColors` for backward compatibility (e.g., `heroGradient = primaryGradient`). Prefer the canonical name.
