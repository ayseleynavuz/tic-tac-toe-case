import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/src/core/services/local/local_service.dart';

class UserService {
  static final UserService _instance = UserService._init();

  static UserService get instance => _instance;
  UserService._init();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String _userCollection = 'users';

  Future<bool> saveUsername(String userName) async {
    try {
      await instance._db.collection(_userCollection).add({
        'username': userName,
      }).then((value) {
        log("User added with id: ${value.id}");
        LocalCaching.instance.setUserDocId(value.id);
      });
      instance.username = userName;
      return true;
    } catch (e) {
      log("Error : $e");
      return false;
    }
  }

  String? username;

  Future<void> getUsername() async {
    try {
      final String? userId = LocalCaching.instance.userDocId;
      if (userId == null) return;

      final DocumentSnapshot<Map<String, dynamic>> user =
          await _db.collection(_userCollection).doc(userId).get();
      username = user.data()!['username'];
    } catch (e) {
      log("Error : $e");
    }
  }
}
