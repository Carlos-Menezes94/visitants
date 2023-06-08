import 'package:flutter/cupertino.dart';
import 'package:visitants/core/app_state.dart';
import '../../../../../core/store.dart';

class LoginStore extends Store {
  ValueNotifier<AppState> state = ValueNotifier<AppState>(AppState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailText = "rafael@gmail.com";
  String passwordText = "Smile@21";
  BuildContext? context;
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  bool didCheckAuth = false;
}
