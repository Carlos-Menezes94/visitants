import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../core/response.dart';
import 'login_data_source_abstract.dart';

class LoginDataSourceImpl implements LoginDataSourceAbstract {
  @override
  Future<DataSourceResponse> logoutLogin() async {
    throw UnimplementedError();

    // await authFirebase.signOut();
    // if (authFirebase.currentUser == null) {
    //   return DataSourceResponse(data: "", success: true);
    // } else {
    //   return DataSourceResponse(data: "", success: false);
    // }
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
}
