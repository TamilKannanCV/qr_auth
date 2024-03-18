import 'package:dartz/dartz.dart';

abstract interface class QRRepo {
  Future<Either<String, dynamic>> startQrSession();
  Future<Either<void, dynamic>> endQrSession({required String uid});
  Future<Either<void, dynamic>> authorizeQrSession({required String uid});
}
