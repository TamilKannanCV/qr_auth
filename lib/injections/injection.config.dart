// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:qr_auth/data/repositories/auth_repo.dart' as _i6;
import 'package:qr_auth/data/repositories/qr_repo.dart' as _i4;
import 'package:qr_auth/services/firebase/firebase_service.dart' as _i3;
import 'package:qr_auth/services/firebase/repo/auth_repo_impl.dart' as _i7;
import 'package:qr_auth/services/firebase/repo/qr_repo_impl.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.FirebaseService>(() => _i3.FirebaseService());
    gh.factory<_i4.QRRepo>(
        () => _i5.FirebaseQRRepoImpl(gh<_i3.FirebaseService>()));
    gh.factory<_i6.AuthRepo>(
        () => _i7.FirebaseAuthRepoImpl(gh<_i3.FirebaseService>()));
    return this;
  }
}
