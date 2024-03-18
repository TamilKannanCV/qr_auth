import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_auth/extensions/string_extensions.dart';
import 'package:qr_auth/global/log/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

@singleton
class FirebaseService {
  User? getCurrentUser() => FirebaseAuth.instance.currentUser;

  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.standard();
    final account = await googleSignIn.signIn();
    final authentication = await account?.authentication;
    if (authentication == null) {
      throw Exception("Authentication is null");
    }
    final auth = await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    ));
    final user = auth.user;
    if (user == null) {
      throw Exception("User is  null");
    }
    return user;
  }

  Future<User> signInWithToken({required String token}) async {
    final cred = await FirebaseAuth.instance.signInWithCustomToken(token);
    final user = cred.user;
    if (user == null) {
      throw Exception("User is  null");
    }
    return user;
  }

  Future<String> getIdToken({bool forceRefresh = false}) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken(forceRefresh);
    logger.d(token);
    if (token == null) {
      throw Exception("Token is null");
    }
    return token;
  }

  Future<void> signOut() async {
    await GoogleSignIn.standard().signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<String> startQrSession() async {
    final uid = const Uuid().v8();
    final db = FirebaseDatabase.instance.ref("qr_sessions/$uid");

    final data = {
      "id": uid,
    };
    await db.set(data);
    return json.encode(data).encrypt();
  }

  Future<void> endQrSession({required String uid}) async {
    final db = FirebaseDatabase.instance.ref("qr_sessions/$uid");
    await db.remove();
  }

  Future<void> authenticateQr({required String uid}) async {
    final db = FirebaseDatabase.instance.ref("qr_sessions/$uid");
    if ((await db.get()).exists == false) {
      throw Exception("UID not exists");
    }
    final user = FirebaseAuth.instance.currentUser;
    final res = await http.get(Uri.parse("${dotenv.get("CUSTOM_TOKEN_BASE_URL")}/customToken?uid=${user?.uid}"));
    if (res.statusCode != 200) {
      throw Exception("Error fetching custom token");
    }
    final resp = json.decode(res.body) as Map<String, dynamic>;

    final token = resp["customToken"] as String?;
    logger.d(token);
    await db.update({
      "token": token?.encrypt(),
    });
  }
}
