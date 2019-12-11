import 'package:firebase_auth/firebase_auth.dart';
import 'package:telegram_clone/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';

  Stream<FirebaseUser> user() {
    return _auth.onAuthStateChanged;
  }

  Future createWithPhoneNum(String phone) async {
    final PhoneCodeSent codeSent = (String verId, [int forcedResendToken]) {
      print('code sent to $phone');
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) async {
      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      print('user logged in with phone::uid:${user.uid}');
    };

    final PhoneVerificationFailed verificationFailed = (AuthException e) {
      print('verification failed');
      print(e.message);
    };

    final PhoneCodeAutoRetrievalTimeout retrievalTimeOut = (String verId) {
      print('auto retrieval timeout reached');
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          codeSent: codeSent,
          verificationFailed: verificationFailed,
          verificationCompleted: verificationCompleted,
          timeout: Duration(seconds: 10),
          codeAutoRetrievalTimeout: retrievalTimeOut);
    } catch (e) {
      return null;
    }
  }

  // void _signInWithPhoneNumber(String smsCode) async {
  //   final _authCredential = await PhoneAuthProvider.getCredential(
  //       verificationId: _verificationId, smsCode: smsCode);
  //   _auth
  //       .signInWithCredential(_authCredential)
  //       .catchError((error) {})
  //       .then((user) async {});
  // }

  Future<User> createUser(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      return User.fromFirebaseUser(user);
    } catch (ple) {
      print(ple.toString());
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
