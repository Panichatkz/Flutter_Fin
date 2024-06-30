import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/material.dart';
import '../models/user.dart' as CustomUser;

class AuthService extends ChangeNotifier {
  final FirebaseAuth.FirebaseAuth _auth = FirebaseAuth.FirebaseAuth.instance;

  CustomUser.User? _userFromFirebase(FirebaseAuth.User? user) {
    if (user == null) {
      return null;
    }
    return CustomUser.User(
      uid: user.uid,
      email: user.email ?? '',
      isAuthenticated: true, // Assuming authenticated if user is not null
    );
  }

  Stream<CustomUser.User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in: $e');
      rethrow; // Rethrow the error to handle in the UI
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error registering user: $e');
      rethrow; // Rethrow the error to handle in the UI
    }
  }

  CustomUser.User? get currentUser {
    FirebaseAuth.User? user = _auth.currentUser;
    return _userFromFirebase(user);
  }

  Future<void> automaticSignIn() async {
    CustomUser.User? user = currentUser;
    if (user != null) {
      // If user is already signed in, you might want to validate the session or token
      print('Automatic sign-in successful for ${user.email}');
    } else {
      // If no session or token found, navigate to login screen or handle as needed
      print('No stored session or token, navigate to login screen');
      // Example: Navigate to login screen
      // Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushNamed(
          context, '/auth'); // Navigate to '/auth' after signing out
    } catch (e) {
      print('Error signing out: $e');
      // Handle error as needed
    }
  }
}
