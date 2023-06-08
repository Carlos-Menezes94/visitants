import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitants/app/features/login/domain/failures/cant_realize_of_login_failure.dart';
import 'package:visitants/app/features/login/domain/usecases/signin_login_use_case.dart';
import 'package:visitants/core/controller.dart';

import '../../../home/presentation/pages/home_page.dart';
import '../stores/login_store.dart';

class LoginController extends Controller {
  final LoginStore store;
  final SignInLoginUseCase signInLoginUseCase;

  LoginController({required this.signInLoginUseCase, required this.store});

  void closeKeyboardOnOutsideClick() {
    store.focusNodeEmail.unfocus();
    store.focusNodePassword.unfocus();
  }

  Future<void> checkAuth(BuildContext context) async {
    User? user;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.authStateChanges().listen((User? userInital) {
      user = (userInital == null) ? null : userInital;
    });

    if (_auth.currentUser == null) {
      return;
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Future<void> signinLoginUserFirebase() async {
    final response = await signInLoginUseCase.signinLogin(
        password: store.passwordController.text, email: store.emailText);

    response.fold((failure) {
      CantRealizeOfLoginFailure();
    }, (sucess) {
      print("DEU CERTO");
    });
  }
}
