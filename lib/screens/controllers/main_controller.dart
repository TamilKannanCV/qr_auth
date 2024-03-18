import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:qr_auth/data/repositories/auth_repo.dart';
import 'package:qr_auth/data/repositories/qr_repo.dart';
import 'package:qr_auth/extensions/string_extensions.dart';
import 'package:qr_auth/injections/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../global/log/logger.dart';
import '../main_screen.dart';

part 'main_controller.g.dart';

@riverpod
class SignInWithGoogle extends _$SignInWithGoogle {
  @override
  FutureOr<User?> build() => locator<AuthRepo>().getCurrentUser();

  Future<void> signIn() async {
    state = const AsyncValue.loading();
    final repo = locator<AuthRepo>();
    final res = await repo.signInWithGoogle();
    res.fold((l) {
      state = AsyncValue.data(l);
    }, (r) {
      state = AsyncValue.error(r, StackTrace.current);
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final repo = locator<AuthRepo>();
    final res = await repo.signOut();
    await res.fold((l) async {
      state = const AsyncValue.data(null);
      ref.invalidate(startQrSessionProvider);
    }, (r) {
      state = AsyncValue.error(r, StackTrace.current);
    });
  }

  Future<void> signInWithToken({required String token}) async {
    state = const AsyncValue.loading();
    final repo = locator<AuthRepo>();
    final res = await repo.signInWithToken(token: token);
    res.fold((l) {
      logger.d(l);
      state = AsyncValue.data(l);
    }, (r) {
      state = AsyncValue.error(r, StackTrace.current);
    });
  }
}

@riverpod
Future<String> startQrSession(StartQrSessionRef ref) async {
  final repo = locator<QRRepo>();
  final res = await repo.startQrSession();
  return res.fold((l) {
    final uid = json.decode(l.decrypt())['id'];
    sessionsController = StreamController.broadcast();
    sessionsController.addStream(FirebaseDatabase.instance.ref("qr_sessions/$uid").onValue);
    ref.keepAlive();
    return l;
  }, (r) {
    logger.e(r);
    throw Exception(r);
  });
}

@riverpod
Future<bool> authorizeQrSession(AuthorizeQrSessionRef ref, {required String uid}) async {
  final repo = locator<QRRepo>();
  final res = await repo.authorizeQrSession(uid: uid);
  return res.fold((l) => true, (r) {
    throw Exception(r);
  });
}
