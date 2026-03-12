import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_design/screens/home/home.screen.dart';
// import 'package:simple_design/screens/...';

// ── Global Navigator Key ────────────────────────────
final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();
BuildContext get globalContext => globalNavigatorKey.currentContext!;

final router = GoRouter(
  navigatorKey: globalNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,

  // ── Redirect Logic (Auth Guards) ──────────────────
  redirect: (context, state) {
    // final bool loggedIn = ... check auth state;
    // final bool isLoggingIn = state.matchedLocation == '/login';
    
    // if (!loggedIn && !isLoggingIn) return '/login';
    // if (loggedIn && isLoggingIn) return '/';
    return null;
  },

  routes: [
    GoRoute(
      path: HomeScreen.routeName,
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);