import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';
import 'user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password from Firebase Authentication
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with email and password from Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get User Data from Firestore
      UserModel user =
          await UserService().getUserById(userCredential.user!.uid);

      // Return UserModel
      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out from Firebase Authentication
  Future<void> signOut() async {
    try {
      // Sign out from Firebase Authentication
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
