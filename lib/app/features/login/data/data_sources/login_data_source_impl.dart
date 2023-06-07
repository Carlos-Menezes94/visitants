import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../core/response.dart';
import 'login_data_source_abstract.dart';

class LoginDataSourceImpl implements LoginDataSourceAbstract {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<DataSourceResponse> logoutLogin() async {
    await auth.signOut();
    if (auth.currentUser == null) {
      return DataSourceResponse(data: "", success: true);
    } else {
      return DataSourceResponse(data: "", success: false);
    }
  }

  @override
  Future<DataSourceResponse> registerLogin(
      {required String password, required String email}) async {
    final response = await auth.createUserWithEmailAndPassword(
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
    final response =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (response.user != null) {
      return DataSourceResponse(data: response.user, success: true);
    } else {
      return DataSourceResponse(data: response.user, success: false);
    }
  }
}
