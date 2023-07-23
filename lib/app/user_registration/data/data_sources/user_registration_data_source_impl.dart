import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitants/app/user_registration/data/data_sources/user_registration_data_source_abstract.dart';
import 'package:visitants/core/response.dart';

class UserRegistrationDataSourceImpl
    implements UserRegistrationDataSourceAbstract {
  @override
  Future<DataSourceResponse> newUserRegistration(
      {required String email, required String password}) async {
    FirebaseAuth authFirebase = FirebaseAuth.instance;
    final response = await authFirebase.createUserWithEmailAndPassword(
        email: email, password: password);
    if (response.user != null) {
      return DataSourceResponse(success: true, data: response);
    } else {
      return DataSourceResponse(success: false, data: response);
    }
  }
}
