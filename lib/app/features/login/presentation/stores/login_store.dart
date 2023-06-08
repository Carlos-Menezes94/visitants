import 'package:flutter/cupertino.dart';
import '../../../../../core/store.dart';

class LoginStore extends Store {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailText = "";
  String passwordText = "";

  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
}
