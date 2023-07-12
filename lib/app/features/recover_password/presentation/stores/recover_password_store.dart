import 'package:flutter/cupertino.dart';
import 'package:visitants/core/store.dart';

import '../../../../../core/app_state.dart';

class RecoverPasswordStore extends Store {
  ValueNotifier<AppState> state = ValueNotifier<AppState>(AppState());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String emailTextToRecoverPassword = "";
}
