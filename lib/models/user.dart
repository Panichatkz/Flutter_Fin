// lib/models/user.dart

class User {
  final String uid;
  final String email;
  final bool isAuthenticated; // Add this property

  User({
    required this.uid,
    required this.email,
    this.isAuthenticated = false, // Default to false
  });
}
