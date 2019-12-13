import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final Firestore _db = Firestore.instance;

  getMessages() {
    _db.collection('');
  }
}
