import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  // set User Data to Firestore
  Future<void> setUser(UserModel user) async {
    try {
      // set User Data to Firestore
      _userReference.doc(user.id).set({
        'name': user.name,
        'email': user.email,
        'role': user.role,
      });
    } catch (e) {
      rethrow;
    }
  }

  // get User Data from Firestore
  Future<UserModel> getUserById(String id) async {
    try {
      // get User Data from Firestore
      DocumentSnapshot user = await _userReference.doc(id).get();

      // Return UserModel
      return UserModel(
        id: id,
        name: user['name'],
        email: user['email'],
        role: user['role'],
      );
    } catch (e) {
      rethrow;
    }
  }
}
