import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepo {
  User? getCurrentUser();
  Future<Either<User, dynamic>> signInWithGoogle();
  Future<Either<User, dynamic>> signInWithToken({required String token});
  Future<Either<String, dynamic>> getIdToken({bool forceRefresh = false});
  Future<Either<void, dynamic>> signOut();
}
