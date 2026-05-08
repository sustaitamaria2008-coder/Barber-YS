import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? user;

  final List<String> admins = [
    "sustaitamaria2008@gmail.com",
    "sustaitarosario2008@gmail.com",
    // PON AQUÍ TU CORREO REAL:
    // "tucorreo@gmail.com",
  ];

  bool get isLoggedIn => user != null;

  bool get isAdmin {
    if (user == null) return false;
    return admins.contains(user!.email);
  }

  Future<void> loginWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();

      if (account == null) {
        debugPrint("Login cancelado");
        return;
      }

      user = account;
      notifyListeners();
    } catch (e) {
      debugPrint("Error login: $e");
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    user = null;
    notifyListeners();
  }
}
