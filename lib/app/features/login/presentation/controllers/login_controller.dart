import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitants/app/features/login/domain/failures/cant_realize_of_login_failure.dart';
import 'package:visitants/app/features/login/domain/usecases/signin_login_use_case.dart';
import 'package:visitants/app/features/login/presentation/login_module.dart';
import 'package:visitants/app/features/login/presentation/pages/login_page.dart';
import 'package:visitants/core/controller.dart';

import '../../../../../core/app_state.dart';
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

  // void checkAuth() async {
  //   store.state.value = AppState.loading();

  //   User? user;
  //   final FirebaseAuth _auth = FirebaseAuth.instance;

  //   _auth.authStateChanges().listen((User? userInital) {
  //     user = (userInital == null) ? null : userInital;
  //   });

  //   if (_auth.currentUser == null) {
  //     LoginModule.to.navigator.pushNamed(LoginPage.routeName);

  //     // Navigator.of(context!)
  //     //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
  //     store.state.value = AppState.error();
  //   } else {
  //     LoginModule.to.navigator.pushNamed(HomePage.routeName);
  //     // Navigator.of(context!)
  //     //     .push(MaterialPageRoute(builder: (context) => HomePage()));
  //     store.state.value = AppState.success();
  //   }
  // }

  // Future<void> signinLoginUserFirebase(BuildContext context) async {
  //   store.state.value = AppState.loading();

  //   final response = await signInLoginUseCase.signinLogin(
  //       password: store.passwordText, email: store.emailText);

  //   response.fold((failure) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(failure.message)));
  //   }, (sucess) {
  //     return checkAuth();
  //   });
  // }

  // void logout(BuildContext context) async {
  //   store.state.value = AppState.loading();

  //   final FirebaseAuth _authServiceauth = FirebaseAuth.instance;

  //   await _authServiceauth.signOut();
  //   return checkAuth();
  // }
}
