import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../../core/response.dart';
import 'login_data_source_abstract.dart';

class LoginDataSourceImpl implements LoginDataSourceAbstract {
  @override
  Future<DataSourceResponse> logoutLogin() async {
    FirebaseAuth authFirebase = FirebaseAuth.instance;

    try {
      await authFirebase.signOut();
      return DataSourceResponse(data: "Logout realizado", success: true);
    } catch (errorData) {
      return DataSourceResponse(data: errorData, success: false);
    }
  }

  @override
  Future<DataSourceResponse> registerLogin(
      {required String password, required String email}) async {
    FirebaseAuth authFirebase = FirebaseAuth.instance;

    final response = await authFirebase.createUserWithEmailAndPassword(
        email: email, password: password);
    if (response.user != null) {
      return DataSourceResponse(data: response.user, success: true);
    } else {
      return DataSourceResponse(data: response.user, success: false);
    }
  }

  @override
  Future<DataSourceResponse> signInLogin(
      {required String password, required String email}) async {
    FirebaseAuth authFirebase = FirebaseAuth.instance;

    final response = await authFirebase.signInWithEmailAndPassword(
        email: email, password: password);
    if (response.user != null) {
      return DataSourceResponse(data: response.user, success: true);
    } else {
      return DataSourceResponse(data: response.user, success: false);
    }
  }

  @override
  Future<DataSourceResponse> socialLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      return DataSourceResponse(success: true, data: googleUser);
    } else {
      return DataSourceResponse(success: false, data: googleUser);
    }
  }
}
