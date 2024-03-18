// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$startQrSessionHash() => r'3b8c340984cf237cd7b2b61dc8e2cad0fd6df98c';

/// See also [startQrSession].
@ProviderFor(startQrSession)
final startQrSessionProvider = AutoDisposeFutureProvider<String>.internal(
  startQrSession,
  name: r'startQrSessionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$startQrSessionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StartQrSessionRef = AutoDisposeFutureProviderRef<String>;
String _$authorizeQrSessionHash() =>
    r'6c96dce0f8bda317dcccacd67d26c513fd5f61d7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [authorizeQrSession].
@ProviderFor(authorizeQrSession)
const authorizeQrSessionProvider = AuthorizeQrSessionFamily();

/// See also [authorizeQrSession].
class AuthorizeQrSessionFamily extends Family<AsyncValue<bool>> {
  /// See also [authorizeQrSession].
  const AuthorizeQrSessionFamily();

  /// See also [authorizeQrSession].
  AuthorizeQrSessionProvider call({
    required String uid,
  }) {
    return AuthorizeQrSessionProvider(
      uid: uid,
    );
  }

  @override
  AuthorizeQrSessionProvider getProviderOverride(
    covariant AuthorizeQrSessionProvider provider,
  ) {
    return call(
      uid: provider.uid,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'authorizeQrSessionProvider';
}

/// See also [authorizeQrSession].
class AuthorizeQrSessionProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [authorizeQrSession].
  AuthorizeQrSessionProvider({
    required String uid,
  }) : this._internal(
          (ref) => authorizeQrSession(
            ref as AuthorizeQrSessionRef,
            uid: uid,
          ),
          from: authorizeQrSessionProvider,
          name: r'authorizeQrSessionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$authorizeQrSessionHash,
          dependencies: AuthorizeQrSessionFamily._dependencies,
          allTransitiveDependencies:
              AuthorizeQrSessionFamily._allTransitiveDependencies,
          uid: uid,
        );

  AuthorizeQrSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AuthorizeQrSessionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthorizeQrSessionProvider._internal(
        (ref) => create(ref as AuthorizeQrSessionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AuthorizeQrSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorizeQrSessionProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AuthorizeQrSessionRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _AuthorizeQrSessionProviderElement
    extends AutoDisposeFutureProviderElement<bool> with AuthorizeQrSessionRef {
  _AuthorizeQrSessionProviderElement(super.provider);

  @override
  String get uid => (origin as AuthorizeQrSessionProvider).uid;
}

String _$signInWithGoogleHash() => r'005195548b5dfcf49c789df44ffd12f24d1d6fcd';

/// See also [SignInWithGoogle].
@ProviderFor(SignInWithGoogle)
final signInWithGoogleProvider =
    AutoDisposeAsyncNotifierProvider<SignInWithGoogle, User?>.internal(
  SignInWithGoogle.new,
  name: r'signInWithGoogleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signInWithGoogleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignInWithGoogle = AutoDisposeAsyncNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
