# Flutter Design System — Master Plan
**Version:** Draft v1.0  
**Date:** March 12, 2026  
**Author:** For Review

---

## Table of Contents

1. [Vision & Goals](#1-vision--goals)
2. [Design Philosophy](#2-design-philosophy)
3. [Repository Structure](#3-repository-structure)
4. [Architecture — How It Fits WithCenter](#4-architecture--how-it-fits-withcenter)
5. [Design Tokens — The Foundation](#5-design-tokens--the-foundation)
6. [Component Library — Full Scope](#6-component-library--full-scope)
7. [The 11 Showcase Pages](#7-the-11-showcase-pages)
8. [Component Quality Checklist](#8-component-quality-checklist)
9. [Incremental Build Milestones](#9-incremental-build-milestones)
10. [How Other Projects Use This System](#10-how-other-projects-use-this-system)
11. [Naming Conventions](#11-naming-conventions)
12. [Decisions Made](#12-decisions-made)

---

## 1. Vision & Goals

### One-Line Mission
> A clean, minimal, consistent Flutter design system that any developer can pick up in minutes and any project can adopt without friction.

### Core Goals

| Goal | What It Means in Practice |
|---|---|
| **Easy to use** | Any component works in 1–2 lines of code |
| **Consistent** | Every pixel follows a token — no hardcoded values ever |
| **Maintainable** | Change one token, the whole system updates |
| **Extendable** | Any project can override tokens to match their brand |
| **Standard-compliant** | Follows Material 3 + WCAG AA — familiar to any Flutter developer |

### What This Is NOT
- Not a UI kit with 100 random widgets
- Not opinionated about business logic or state
- Not tied to any backend or architecture

---

## 2. Design Philosophy

### The 5 Non-Negotiables

These rules apply to every single component — no exceptions.

**1. Theme Only — No Hardcoded Values**
```dart
// ❌ Never
Container(color: Color(0xFF1A1A1A))
Container(color: Color(0xFFF5F5F5))

// ✅ Always
Container(color: Theme.of(context).colorScheme.surface)
Container(color: Theme.of(context).colorScheme.onBackground)
```

**2. Every Component Has All 5 States**
```
default → hover/focused → pressed/active → loading → disabled
```

**3. Minimum Touch Target: 48dp (Fitts's Law)**
```dart
static const double touchTarget = 48.0; // non-negotiable
```

**4. Every Icon Has a Text Label (Your Requirement)**
```dart
// ❌ Icon alone
Icon(Icons.home)

// ✅ Icon with label
SDIconLabel(icon: Icons.home, label: 'Home')
```

**5. Semantic Accessibility on Every Widget**
```dart
Semantics(label: 'Submit form', button: true, child: SDButton.primary(...))
```

### Design Laws Applied

| Law | How We Apply It |
|---|---|
| **Hick's Law** | Max 4 variants per component (primary, secondary, ghost, danger) |
| **Fitts's Law** | All interactive elements ≥ 48dp touch target |
| **Jakob's Law** | Follow Material 3 naming — developers already know it |
| **Minimalism** | White/grey palette, generous whitespace, typography does the work |

### Visual Direction: Clean & Minimal

```
Color palette:   Near-white backgrounds, grey surfaces, one accent
Typography:      System font (Inter / DM Sans), clear scale
Spacing:         8pt grid — all values are multiples of 4 or 8
Radius:          Consistent, slightly rounded (4dp–12dp range)
Shadows:         Subtle — used sparingly, only where needed
Animation:       Fast (100ms), purposeful, never decorative
```

---

## 3. Repository Structure

### Top-Level Layout

```
sd_flutter/                          ← Root repo (Git)
│
├── README.md                        ← Setup, usage, contributing guide
├── CHANGELOG.md                     ← Version history
│
├── simple_design/                   ← THE PACKAGE (what others import)
│   ├── lib/
│   │   ├── src/
│   │   │   ├── tokens/              ← SDAnimation (+ SDTheme in theme/)
│   │   │   ├── theme/               ← SDTheme — light + dark via ColorScheme.fromSeed
│   │   │   ├── components/          ← All widgets
│   │   │   │   ├── buttons/
│   │   │   │   ├── inputs/
│   │   │   │   ├── cards/
│   │   │   │   ├── navigation/
│   │   │   │   ├── feedback/        ← Alerts, Snackbars, Toasts, Modals
│   │   │   │   ├── data_display/    ← Tables, Lists, Badges, Avatars
│   │   │   │   ├── layout/          ← Bento, Accordion, Carousel
│   │   │   │   └── typography/      ← SDText variants
│   │   │   └── utils/               ← Extensions, helpers
│   │   └── simple_design.dart       ← Single barrel export
│   └── pubspec.yaml
│
└── sd_showcase/                     ← DEMO APP (the 10 UI pages)
    ├── lib/
    │   ├── main.dart
    │   ├── router.dart              ← go_router — all 10 pages wired
    │   ├── screens/                 ← 10 showcase screens
    │   │   ├── home/
    │   │   ├── buttons/
    │   │   ├── forms/
    │   │   ├── cards/
    │   │   ├── navigation/
    │   │   ├── feedback/
    │   │   ├── data_display/
    │   │   ├── layout/
    │   │   ├── typography/
    │   │   └── theme/
    │   └── widgets/
    │       └── showcase_wrapper.dart
    └── pubspec.yaml
```

### Key Rule: Package vs App Separation

| `simple_design/` (The Package) | `sd_showcase/` (The App) |
|---|---|
| Zero dependency on go_router | Uses go_router for routing |
| Zero dependency on provider | Uses provider for showcase state |
| Pure UI + tokens | Wires up and demonstrates components |
| What other projects import | Never imported by other projects |

---

## 4. Architecture — How It Fits WithCenter

The WithCenter architecture is kept **100% intact** in the showcase app. The design system sits as a clean layer below it.

### How They Connect

```
WithCenter App (any project)
│
├── main.dart          ← MultiProvider (as per WithCenter pattern)
├── router.dart        ← GoRouter (as per WithCenter pattern)
├── states/            ← ChangeNotifier states (as per WithCenter pattern)
├── services/          ← Business logic (as per WithCenter pattern)
├── repositories/      ← DB access (as per WithCenter pattern)
│
└── screens/           ← Uses SD components instead of raw Flutter widgets
    └── quiz/
        └── quiz.list.screen.dart
            └── uses SDButton, SDCard, SDTextField  ← from simple_design
```

### Showcase App — WithCenter Pattern Applied

The `sd_showcase` app itself follows WithCenter architecture:

```dart
// main.dart — identical WithCenter pattern
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState()),
        ChangeNotifierProvider(create: (_) => ShowcaseState()),
      ],
      child: const ShowcaseApp(),
    ),
  );
}

// router.dart — identical WithCenter pattern
final router = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: [
    GoRoute(path: HomeScreen.routeName, ...),
    GoRoute(path: ButtonsScreen.routeName, ...),
    // ... all 10 screens
  ],
);
```

---

## 5. Design Tokens — The Foundation

**Token philosophy:** Use Flutter's built-in theme system wherever it provides the value. Only define custom tokens for things Flutter doesn't cover.

| What | How | Why |
|---|---|---|
| Colors | `Theme.of(context).colorScheme.*` | Flutter generates a full accessible palette from one seed color |
| Typography | `Theme.of(context).textTheme.*` | Flutter's Material 3 type scale matches our needs |
| Spacing / Radius / Sizes | Raw component-level constants | Flutter has no built-in spacing or radius tokens |
| Animation | `SDAnimation` class | Flutter has no built-in timing tokens |

### 5.1 Theming — Colors & Typography

`SDTheme` generates both light and dark themes from a single grey-blue seed color. All components read colors and text styles from the active theme — never hardcoded values.

```dart
// SDTheme — single seed → full accessible ColorScheme (light + dark)
class SDTheme {
  static const _seed = Color(0xFF607D8B); // subtle grey-blue

  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark),
    useMaterial3: true,
  );
}

// In every component — always read from theme, never hardcode:
// ✅ Theme.of(context).colorScheme.surface
// ✅ Theme.of(context).colorScheme.primary
// ✅ Theme.of(context).textTheme.bodyMedium
// ❌ Color(0xFFF5F5F5)
// ❌ TextStyle(fontSize: 14)
```

### 5.2 Animation Tokens

The one custom token class — Flutter has no built-in timing or easing tokens.

```dart
class SDAnimation {
  static const fast   = Duration(milliseconds: 100);  // Hover, press
  static const normal = Duration(milliseconds: 200);  // Expand, collapse
  static const slow   = Duration(milliseconds: 350);  // Modals, page transitions
  static const curve  = Curves.easeInOut;
}
```

---

## 6. Component Library — Full Scope

### Tier 1 — Foundation (v0.1)
*Must exist before anything else can be built.*

- `SDButton` — primary, secondary, ghost, danger, icon+label, loading state
- `SDText` — thin wrapper over TextStyle tokens
- `SDIconLabel` — icon + text label always together
- `SDDivider` — horizontal and vertical
- `SDSpinner` — loading indicator

### Tier 2 — Forms & Inputs (v0.2)

- `SDTextField` — default, focused, error, disabled states
- `SDDropdown` — single select
- `SDMultiSelect` — multi-select dropdown
- `SDCheckbox` — with label
- `SDRadio` — radio group
- `SDSwitch` — toggle with label
- `SDSlider` — range input
- `SDDatePicker` — minimal, clean
- `SDForm` — form wrapper with validation helpers

### Tier 3 — Data Display (v0.3)

- `SDCard` — basic, action, stat, image variants
- `SDList` — list tile with icon, title, subtitle, trailing
- `SDTable` — headers, rows, sorting indicator
- `SDBadge` — count, status, label
- `SDAvatar` — image, initials, fallback
- `SDChip` — filter chip, tag chip
- `SDTag` — inline label/status indicator

### Tier 4 — Feedback & Overlays (v0.4)

- `SDAlert` — info, success, warning, error with icon + dismiss
- `SDModal` — standard, destructive, with/without footer
- `SDSnackbar` — auto-dismiss, with action, top/bottom position
- `SDToast` — 3s auto-dismiss, swipe to dismiss
- `SDBottomSheet` — modal and persistent variants
- `SDProgressBar` — linear progress
- `SDSkeletonLoader` — loading placeholder

### Tier 5 — Navigation (v0.5)

- `SDAppBar` — with title, back button, actions
- `SDTabs` — horizontal tab bar
- `SDBottomNav` — bottom navigation bar (icons with labels)
- `SDDrawer` — side navigation drawer
- `SDBreadcrumb` — breadcrumb trail
- `SDStepIndicator` — multi-step progress

### Tier 6 — Advanced Layout (v0.6)

- `SDAccordion` — expand/collapse sections
- `SDCarousel` — horizontal scrolling cards
- `SDBentoBox` — grid-based bento layout
- `SDEmptyState` — illustration + message + CTA
- `SDDividerLabel` — divider with centered text

### Tier 7 — Entry Screens (v0.7)

Pre-built, customizable full screens. Apps pass callbacks and optional branding widgets — the layout and design system components are handled internally.

**Standard approach:** Each screen accepts required callbacks (`onSubmit`, `onNavigate`) and optional overrides (`logoWidget`, `title`, `subtitle`). They are `StatefulWidget`s — form state is managed internally.

- `SDSplashScreen` — logo + animated loading, auto-navigates after delay. Use with `flutter_native_splash` for the true native layer.
  ```dart
  SDSplashScreen(
    logo: Image.asset('assets/logo.png'),
    onComplete: () => context.go('/home'),
  )
  ```
- `SDLoginScreen` — email + password fields, login button, "forgot password" + "register" links
  ```dart
  SDLoginScreen(
    onLogin: (email, password) async { ... },
    onForgotPassword: () => context.go('/forgot'),
    onRegister: () => context.go('/register'),
  )
  ```
- `SDRegisterScreen` — name + email + password + confirm password, submit button
- `SDForgotPasswordScreen` — email field + "Send reset link" button, success state
- `SDOnboardingScreen` — swipeable cards with title, description, illustration slot, skip + next buttons

---

## 7. The 11 Showcase Pages

Each page lives in `sd_showcase/lib/screens/`. Every page uses **only** components from `simple_design`.

| # | Page | What It Showcases |
|---|---|---|
| 1 | **Home / Overview** | Design system intro, color palette, spacing scale, type scale |
| 2 | **Buttons** | All variants, all states (loading, disabled), icon+label, sizes |
| 3 | **Forms & Inputs** | Text fields, dropdowns, checkboxes, radio, switch, slider, date picker, full form with validation |
| 4 | **Cards** | Basic, action, stat, image, horizontal, loading skeleton |
| 5 | **Navigation** | App bar, tabs, bottom nav, drawer, breadcrumbs, step indicator |
| 6 | **Feedback** | Alerts (all types), snackbar demo, toast demo, modal demo, bottom sheet demo |
| 7 | **Data Display** | Table, list, badge, avatar, chip, tag — with real data examples |
| 8 | **Typography** | Full type scale, color variations, code blocks, truncation |
| 9 | **Layout & Advanced** | Accordion, carousel, bento box, empty state, dividers |
| 10 | **Entry Screens** | Splash, login, register, forgot password, onboarding — interactive demos |
| 11 | **Theme Switcher** | Light / dark mode toggle, live theming demo |

### Showcase App Navigation (go_router)

```dart
// router.dart — all 11 pages
final router = GoRouter(
  navigatorKey: globalNavigatorKey,
  initialLocation: HomeScreen.routeName,
  routes: [
    ShellRoute(                           // Persistent side nav / bottom nav
      builder: (context, state, child) => ShowcaseShell(child: child),
      routes: [
        GoRoute(path: HomeScreen.routeName,        ...),
        GoRoute(path: ButtonsScreen.routeName,     ...),
        GoRoute(path: FormsScreen.routeName,       ...),
        GoRoute(path: CardsScreen.routeName,       ...),
        GoRoute(path: NavigationScreen.routeName,  ...),
        GoRoute(path: FeedbackScreen.routeName,    ...),
        GoRoute(path: DataScreen.routeName,        ...),
        GoRoute(path: TypographyScreen.routeName,  ...),
        GoRoute(path: LayoutScreen.routeName,      ...),
        GoRoute(path: EntryScreen.routeName,       ...),
        GoRoute(path: ThemeScreen.routeName,       ...),
      ],
    ),
  ],
);
```

---

## 8. Component Quality Checklist

Every component must pass **all 7 checks** before it is considered done.

```
□ 1. Uses only design tokens — no hardcoded colors, sizes, or spacing
□ 2. All 5 states implemented — default, focused, pressed, loading, disabled
□ 3. Touch target ≥ 48dp — verified on a real device
□ 4. WCAG AA contrast — text contrast ≥ 4.5:1 verified
□ 5. Semantic label — Semantics widget wrapping every interactive element
□ 6. Simple API — usable in 1–2 lines without reading docs
□ 7. Documented — dartdoc comment with one usage example
```

---

## 9. Incremental Build Milestones

### v0.1 — Foundation *(Start here)*
**Goal:** The system is set up. You can use tokens and one component in a real app.
- [ ] Repo created, folder structure in place
- [ ] `SDAnimation` token file
- [ ] `SDTheme` — light + dark themes from `ColorScheme.fromSeed` (both from day one)
- [ ] `SDButton` — all 4 variants, all 5 states
- [ ] `SDText` — all typography variants
- [ ] `SDIconLabel` — icon + label always together
- [ ] Showcase Page 1 (Home) and Page 2 (Buttons) working

### v0.2 — Forms & Inputs
- [ ] All input components (Tier 2)
- [ ] Form validation helpers
- [ ] Showcase Page 3 (Forms)

### v0.3 — Data Display
- [ ] All data display components (Tier 3)
- [ ] Showcase Pages 4 (Cards) and 7 (Data Display)

### v0.4 — Feedback & Overlays
- [ ] All feedback components (Tier 4)
- [ ] Showcase Page 6 (Feedback)

### v0.5 — Navigation
- [ ] All navigation components (Tier 5)
- [ ] Showcase Page 5 (Navigation)
- [ ] ShellRoute wired in showcase app

### v0.6 — Advanced Layout
- [ ] All advanced layout components (Tier 6)
- [ ] Showcase Pages 8, 9 (Typography, Layout)

### v0.7 — Entry Screens
- [ ] `SDSplashScreen` — logo + animation, auto-navigate callback
- [ ] `SDLoginScreen` — email/password, forgot + register links, loading state
- [ ] `SDRegisterScreen` — name/email/password/confirm, validation
- [ ] `SDForgotPasswordScreen` — email field, send link, success state
- [ ] `SDOnboardingScreen` — swipeable cards, skip/next/done
- [ ] Showcase Page 10 (Entry Screens)

### v1.0 — Complete System
- [ ] Showcase Page 11 (Theme Switcher — light/dark/system toggle demo)
- [ ] All 11 pages complete
- [ ] README with full usage guide
- [ ] CHANGELOG written
- [ ] Shared with team / Mr. Song

---

## 10. How Other Projects Use This System

### As a Git Dependency (Primary Method)

```yaml
# In any project's pubspec.yaml
dependencies:
  simple_design:
    git:
      url: https://github.com/your-org/sd_flutter.git
      path: simple_design
      ref: main   # or pin to a tag: v0.1.0
```

### Usage in Any App

```dart
// 1. Import once
import 'package:simple_design/simple_design.dart';

// 2. Apply theme once in main.dart — both light and dark included
MaterialApp(
  theme: SDTheme.light,
  darkTheme: SDTheme.dark,
  themeMode: ThemeMode.system,  // or ThemeMode.light / .dark
  ...
)

// 3. Use components anywhere — no other setup needed
SDButton.primary(
  label: 'Submit',
  onPressed: () {},
)

SDTextField(
  label: 'Email',
  hint: 'Enter your email',
)
```

### Theme Override (Brand Customization)

```dart
// Any project can override the seed color to match their brand
SDTheme.withSeed(Color(0xFF4A90D9))  // generates full light + dark from brand color
```

---

## 11. Naming Conventions

### Files

```
sd_button.dart          ← component file
sd_button_variants.dart ← sub-variants if file gets too large
sd_animation.dart       ← token file
```

### Classes & Widgets

```dart
SDButton          ← Component class (SD prefix)
SDTheme           ← Theme builder (SD prefix)
SDAnimation       ← Token class (SD prefix)
SDSplashScreen    ← Entry screen (SD prefix)
```

### Constructors / Variants (Named Constructors)

```dart
SDButton.primary(...)    ← Default action
SDButton.secondary(...)  ← Less prominent action
SDButton.ghost(...)      ← Minimal, no background
SDButton.danger(...)     ← Destructive action

SDAlert.info(...)
SDAlert.success(...)
SDAlert.warning(...)
SDAlert.error(...)
```

### File Naming (WithCenter Pattern Adapted)

```
sd_button.dart              ← sd_[component].dart
sd_text_field.dart          ← sd_[component].dart
buttons.screen.dart         ← [feature].screen.dart (in showcase)
home.screen.dart
```

---

## 12. Decisions Made

All open questions resolved — no blockers before coding.

| # | Question | Decision |
|---|---|---|
| 1 | **Font family** | Device default — SF Pro on iOS, Roboto on Android. No bundled font. |
| 2 | **Accent color** | Subtle grey-blue (`Color(0xFF607D8B)`) as the `ColorScheme.fromSeed` seed color. |
| 3 | **Dark theme** | From day one — `SDTheme.light` and `SDTheme.dark` both in v0.1. |
| 4 | **Package name** | `simple_design` (import: `package:simple_design/simple_design.dart`) |
| 5 | **Min Flutter SDK** | Flutter 3.16+ — requires stable Material 3 + `ColorScheme.fromSeed` single-seed API. |
| 6 | **Repo visibility** | Owner handles repo visibility. |
| 7 | **Claude Code skills** | No scaffold commands yet. Custom Claude skills needed later to help Claude use this design system. |

---


*This document is a living plan. Review, comment, and we update it before writing any code.*
