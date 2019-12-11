import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User {
  final String uid;

  User({@required this.uid});

  static fromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
}
