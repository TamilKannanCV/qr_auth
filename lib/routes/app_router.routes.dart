import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_auth/screens/main_screen.dart';

part 'app_router.routes.g.dart';

@TypedGoRoute<MainRoute>(path: '/')
class MainRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MainScreen();
  }
}
