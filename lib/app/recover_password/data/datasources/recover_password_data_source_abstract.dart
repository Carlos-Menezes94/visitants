import '../../../../../../core/response.dart';

abstract class RecoverPasswordDataSourceAbstract {
  Future<DataSourceResponse> recoverPassword({required String email});
}
