import 'package:flutter/material.dart';
import 'package:wallet_app/global/services/auth/auth_service.dart';
import 'package:wallet_app/global/services/firebase/firebase_service.dart';
class HomeController {

  final AuthService authService = AuthService();
  final FirebaseService _firebaseService = FirebaseService();

  String extractUsernameFromEmail(String email) {
    // Split the email address using the '@' symbol
    List<String> parts = email.split('@');

    // The username is the first part of the split result
    String username = parts[0];

    // Remove any non-alphanumeric characters from the username
    username = username.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    return username;
  }

  Future<String?> loadImageUrl(email) async {
    final imageUrl = await _firebaseService.getImageFromFirebase(email!);
    return imageUrl;
  }

 
}