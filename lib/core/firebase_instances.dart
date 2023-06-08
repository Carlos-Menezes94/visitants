import 'package:firebase_auth/firebase_auth.dart';

class FirebaseInstances {
  final FirebaseAuth _firebaseAuth;
  FirebaseInstances(this._firebaseAuth);

  FirebaseAuth get getFireStoreInstance => this._firebaseAuth;
}
