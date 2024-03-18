import 'dart:convert';

import 'package:encrypt/encrypt.dart';

extension StringExtension on String {
  String encrypt() {
    final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');

    final b64key = Key.fromUtf8(base64Url.encode(key.bytes).substring(0, 32));
    final fernet = Fernet(b64key);
    final encrypter = Encrypter(fernet);

    final encrypted = encrypter.encrypt(this);

    return encrypted.base64;
  }

  String decrypt() {
    final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');

    final b64key = Key.fromUtf8(base64Url.encode(key.bytes).substring(0, 32));
    final fernet = Fernet(b64key);
    final encrypter = Encrypter(fernet);

    final decrypted = encrypter.decrypt64(this);

    return decrypted;
  }
}
