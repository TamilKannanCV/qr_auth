import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_auth/injections/injection.config.dart';

final locator = GetIt.I;

@injectableInit
Future<void> configureDependencies() async => locator.init();
