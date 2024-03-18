import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_auth/data/repositories/auth_repo.dart';
import 'package:qr_auth/injections/injection.dart';
import 'package:qr_auth/screens/main_screen.dart';

import '../screens/scan_screen.dart';

part 'app_router.routes.g.dart';

@TypedGoRoute<MainRoute>(path: '/', routes: [
  TypedGoRoute<ScanRoute>(path: 'scan'),
])
class MainRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainScreen();
  }
}

class ScanRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ScanScreen();
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final authRepo = locator<AuthRepo>();
    if (authRepo.getCurrentUser() == null) {
      return MainRoute().location;
    }
    return null;
  }
}
