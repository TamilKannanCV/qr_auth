import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_auth/data/repositories/qr_repo.dart';
import 'package:qr_auth/global/log/logger.dart';
import 'package:qr_auth/services/firebase/firebase_service.dart';

@Injectable(as: QRRepo)
class FirebaseQRRepoImpl implements QRRepo {
  final FirebaseService _firebaseService;
  FirebaseQRRepoImpl(this._firebaseService);

  @override
  Future<Either<String, dynamic>> startQrSession() async {
    try {
      final res = await _firebaseService.startQrSession();
      return Left(res);
    } catch (e) {
      logger.e(e);
      return Right(e);
    }
  }

  @override
  Future<Either<void, dynamic>> authorizeQrSession({required String uid}) async {
    try {
      final res = await _firebaseService.authenticateQr(uid: uid);
      return Left(res);
    } catch (e) {
      logger.e(e);
      return Right(e);
    }
  }

  @override
  Future<Either<void, dynamic>> endQrSession({required String uid}) async {
    try {
      final res = await _firebaseService.endQrSession(uid: uid);
      return Left(res);
    } catch (e) {
      logger.e(e);
      return Right(e);
    }
  }
}
