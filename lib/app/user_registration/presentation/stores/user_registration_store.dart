import 'package:flutter/cupertino.dart';
import 'package:visitants/core/store.dart';

import '../../../../core/app_state.dart';
import '../../data/models/user_registered_data_model.dart';

class UserRegistrationStore extends Store {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  ValueNotifier<UserRegisteredDataModel> teste =
      ValueNotifier<UserRegisteredDataModel>(UserRegisteredDataModel(
          name: "", email: "", password: "", occupation: "", dateTimeRegistration: ''));
  ValueNotifier<AppState> state = ValueNotifier<AppState>(AppState());
}
