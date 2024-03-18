import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_auth/routes/app_router.routes.dart';

get appRouter => GoRouter(
      routes: $appRoutes,
      initialLocation: '/',
      debugLogDiagnostics: kDebugMode,
    );
