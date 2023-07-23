import 'package:visitants/core/response.dart';

abstract class UserRegistrationDataSourceAbstract {
  Future<DataSourceResponse> newUserRegistration(
      {required String email, required String password});
}
