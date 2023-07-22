import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../core/response.dart';
import 'recover_password_data_source_abstract.dart';

class RecoverPasswordDataSourceImpl
    implements RecoverPasswordDataSourceAbstract {
  @override
  Future<DataSourceResponse> recoverPassword({required String email}) async {
    FirebaseAuth authFirebase = FirebaseAuth.instance;
    try {
      await authFirebase.sendPasswordResetEmail(email: email);
      return DataSourceResponse(data: null, success: true);
    } catch (error) {
      if (error is FirebaseAuthException) {
        return DataSourceResponse(data: error.code, success: false);
      }
      return DataSourceResponse(data: error, success: false);
    }
  }
}
