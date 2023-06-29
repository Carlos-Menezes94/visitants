import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:visitants/core/app_state.dart';
import '../../../../../core/store.dart';

class LoginStore extends Store {
  ValueNotifier<AppState> state = ValueNotifier<AppState>(AppState());
  ValueNotifier<User>? dataUserFirebase;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailText = "rafael@gmail.com";
  String passwordText = "teste@21";
  ValueNotifier<bool> isSplashScreenView = ValueNotifier<bool>(true);

  BuildContext? context;
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  bool didCheckAuth = false;
  ValueNotifier<FirebaseAuth> firebaseAuth =
      ValueNotifier<FirebaseAuth>(FirebaseAuth.instance);
}
