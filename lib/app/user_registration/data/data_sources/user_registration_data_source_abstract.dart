import 'package:visitants/core/response.dart';

import '../models/user_registered_data_model.dart';

abstract class UserRegistrationDataSourceAbstract {
  Future<DataSourceResponse> newUserRegistration(
      {required UserRegisteredDataModel userRegisteredDataModel});
}
