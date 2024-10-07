import '../../../../../../core/response.dart';

abstract class LoginDataSourceAbstract {
  Future<DataSourceResponse> logoutLogin();
  Future<DataSourceResponse> socialLogin();

  Future<DataSourceResponse> signInLogin(
      {required String password, required String email});
  Future<DataSourceResponse> registerLogin(
      {required String password, required String email});
}
