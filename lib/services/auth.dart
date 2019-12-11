import 'package:firebase_auth/firebase_auth.dart';
import 'package:telegram_clone/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';

  Future createWithPhoneNum(String phone) async {
    try {
      return await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: _verificationCompleted,
        verificationFailed: (AuthException e) {
          print('verification failed');
          print(e.message);
        },
        codeSent: _codeSent,
        // codeAutoRetrievalTimeout: (String a) {});
      );
    } catch (e) {
      return null;
    }
  }

  _verificationCompleted(AuthCredential credential) async {
    print('verification complete');
    print(credential);
    // try {
    //   FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    // } catch (e) {}
  }

  _codeSent(String verificationId, [int forceResendingToken]) async {
    this._verificationId = verificationId;
    print('code sent');
  }

  Future<User> createUser(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      return User.fromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> signIn(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return User.fromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {}
  }

  Future<bool> deleteAccount() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      await user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
