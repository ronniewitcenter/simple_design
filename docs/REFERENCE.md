# Simple Design — Conversation Summary
**Date:** March 12, 2026

---

## What This Document Is

A summary of the planning conversation that led to the Simple Design (`sd_flutter`) master plan. Useful for onboarding teammates or picking up the conversation after a break.

---

## How the Conversation Started

The developer's personal notes outlined a clear frustration: using AI to build things without truly understanding them. The goal was to build a design system — later named **Simple Design** — the *right* way: understanding every decision, following standards, and producing something good enough that other people would agree it looks right.

Key phrases from the notes:
- *"You must have consistency"*
- *"Follow the standards"*
- *"The importance here is that you use AI and you can't make it — this time everybody uses AI, you are developers, you know how to use AI, you must be better than AI"*
- *"Icon should have text for better UX"*
- *"Build beautiful design with Flutter — modern, simple, un-colorful, no color or less color"*

---

## Topic 1 — Famous Design Systems on pub.dev

The conversation opened with a question about the most famous Flutter design systems on pub.dev. Key findings:

- Flutter ships two built-in systems: **Material Design 3** and **Cupertino**
- Notable third-party options: `fluent_ui` (Microsoft), `shadcn_ui` (rising fast), `velocity_x`
- Most production teams combine `flutter_screenutil` + `google_fonts` + `flex_color_scheme`

**Outcome:** The developer decided to build their own design system — named **Simple Design** — rather than adopt an existing one.

---

## Topic 2 — Three Key Decisions Made

Three questions were asked to align the direction before planning:

| Question | Answer |
|---|---|
| How will other projects use it? | **As a Git repo** — clone or git dependency, with the 10 showcase pages inside |
| What is the visual style? | **Clean & Minimal** — white/grey, lots of whitespace, typography-first |
| Which components are priority? | **All of them**, but built incrementally |

---

## Topic 3 — UI/UX Principles Integrated

The developer provided a set of UI/UX principles and design laws to be embedded into the system. Each was translated into a concrete, actionable rule:

### Principles → Rules

| Principle | Rule Applied |
|---|---|
| User-Centricity | Every component has one clear purpose. No multi-purpose catch-all widgets. |
| Hierarchy | Typography tokens enforce hierarchy — no freestyle font sizes allowed |
| Consistency (Jakob's Law) | Follow Material 3 naming. If you know Material, you know this system. |
| Accessibility | WCAG AA contrast (4.5:1), touch targets ≥ 48dp, semantic labels on all interactive elements |
| Visibility of System Status | All 5 states defined per component: default, focused, pressed, loading, disabled |
| User Control & Freedom | Destructive actions need confirmation. Feedback always has dismiss or timeout. |
| Mobile-First | All components built for 360dp width first, then scale up |
| Hick's Law | Max 4 variants per component — no decision paralysis |
| Fitts's Law | Minimum 48dp touch target, enforced via `SDSize` tokens |
| Micro-interactions | Purposeful animation durations: fast (100ms), normal (200ms), slow (350ms) |

### The Design System "Constitution" — 7 Rules Every Component Must Pass
1. All 5 states implemented
2. WCAG AA contrast verified
3. Touch target ≥ 48dp
4. Only design tokens used — no hardcoded values
5. Semantic label present
6. API usable in 1–2 lines
7. Material 3 naming conventions followed

---

## Topic 4 — WithCenter Architecture Review

The developer shared WithCenter's Flutter architecture document. Key findings and decisions:

### WithCenter Architecture (Kept 100% Intact)

The layered architecture follows a strict one-directional data flow:

```
UI → State → Service → Repository → Database
```

| Layer | File Pattern | Role |
|---|---|---|
| Model | `feature.model.dart` | Pure data class, `fromMap()` / `toMap()` |
| Repository | `feature.repository.dart` | Raw SQL / DB calls, Singleton |
| Service | `feature.service.dart` | Business logic, named methods, Singleton |
| State | `feature.state.dart` | ChangeNotifier, calls Service, notifies UI |
| Screen | `feature.action.screen.dart` | Full page, reads State via Consumer/Selector |
| Widget | `feature.widget.dart` | Pure UI, receives data via constructor props |

Key patterns used: Singleton, ChangeNotifier + Provider, GoRouter with `state.extra` for passing objects, static `routeName` and `open()` on every screen.

### Critical Decision — Separation of Concerns

The Simple Design package (`sd_core`) must have **zero dependency** on go_router or provider. Those belong only in `sd_showcase`. This keeps the package lightweight and adoptable by any project.

```
sd_core/        ← No go_router. No provider. Pure UI + tokens only.
sd_showcase/    ← Uses go_router + provider, follows WithCenter pattern exactly.
```

---

## Topic 5 — The Master Plan (Produced)

A full markdown plan (`flutter_design_system_plan.md`) was produced covering:

1. **Vision & Goals** — One-line mission, 5 core goals, what the system is NOT
2. **Design Philosophy** — 5 non-negotiables, design laws applied, visual direction
3. **Repository Structure** — Two-folder repo: `sd_core/` (package) + `sd_showcase/` (app)
4. **Architecture** — How WithCenter connects to the Simple Design layer
5. **Design Tokens** — Colors, spacing (8pt grid), typography, radius, animation, size
6. **Component Library** — 6 tiers, ~45 components total
7. **10 Showcase Pages** — What each page demonstrates
8. **Quality Checklist** — 7 checks every component must pass
9. **Incremental Milestones** — v0.1 through v1.0
10. **How Other Projects Use It** — Git dependency setup, theme override
11. **Naming Conventions** — Files (`sd_`), classes (`SD` prefix), named constructors
12. **Open Questions** — 7 decisions still needed before building starts

---

## Open Questions — Still To Be Answered

These were listed at the end of the master plan and need the developer's input before coding begins:

| # | Question |
|---|---|
| 1 | Font family — system default vs. ship with Inter or DM Sans? |
| 2 | Accent color — pure black `#1A1A1A` or a subtle grey-blue? |
| 3 | Dark theme — build in v0.6 or from day one alongside light? |
| 4 | Package name — `sd_core` (confirmed) or a different branded name? |
| 5 | Minimum Flutter SDK — 3.16+ (Material 3 stable) or lower? |
| 6 | Repo visibility — public or private GitHub? |
| 7 | Claude Code commands — write scaffolding commands so Claude Code can generate components automatically? |

---

## Current Status

| Item | Status |
|---|---|
| Project renamed to **Simple Design** (`sd_flutter`) | ✅ Confirmed |
| Visual direction decided | ✅ Clean & Minimal |
| Distribution method decided | ✅ Git repo |
| UI/UX principles integrated | ✅ Mapped to rules |
| WithCenter architecture reviewed | ✅ Kept intact, separated from `sd_core` |
| Master plan document produced | ✅ `flutter_design_system_plan.md` |
| Open questions answered | ⏳ Pending developer review |
| Coding started | ⏳ Not yet — awaiting plan sign-off |

---

## Next Step

Developer reviews the master plan (`flutter_design_system_plan.md`), answers the 7 open questions in Section 12, and signs off. Then coding begins with **v0.1 — Foundation**: tokens, light theme, `SDButton`, `SDText`, `SDIconLabel`, and the first two showcase pages.