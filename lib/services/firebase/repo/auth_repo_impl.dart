import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_auth/global/log/logger.dart';
import 'package:qr_auth/services/firebase/firebase_service.dart';

import '../../../data/repositories/auth_repo.dart';

@Injectable(as: AuthRepo)
class FirebaseAuthRepoImpl implements AuthRepo {
  final FirebaseService _firebaseService;
  FirebaseAuthRepoImpl(this._firebaseService);

  @override
  Future<Either<String, dynamic>> getIdToken({bool forceRefresh = false}) async {
    try {
      final res = await _firebaseService.getIdToken(forceRefresh: forceRefresh);
      return Left(res);
    } catch (e) {
      logger.e(e);
      return Right(e);
    }
  }

  @override
  Future<Either<User, dynamic>> signInWithGoogle() async {
    try {
      final res = await _firebaseService.signInWithGoogle();
      return Left(res);
    } catch (e) {
      logger.e(e);
      return Right(e);
    }
  }

  @override
  Future<Either<User, dynamic>> signInWithToken({required String token}) async {
    try {
      final res = await _firebaseService.signInWithToken(token: token);
      return Left(res);
    } catch (e) {
      logger.e(e);
      return Right(e);
    }
  }

  @override
  User? getCurrentUser() => _firebaseService.getCurrentUser();

  @override
  Future<Either<void, dynamic>> signOut() async {
    try {
      final res = await _firebaseService.signOut();
      return Left(res);
    } catch (e) {
      logger.e(e);
      return Right(e);
    }
  }
}
