import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitants/app/features/login/presentation/login_module.dart';
import 'package:visitants/app/features/login/presentation/pages/login_page.dart';
import 'package:visitants/app/features/login/presentation/stores/login_store.dart';

import '../../../../core/app_state.dart';
import '../../../../module/quick_actions.dart';
import '../../home/presentation/pages/home_page.dart';
import '../domain/usecases/signin_login_use_case.dart';

class LoginQuickActions extends QuickActions<LoginModule> {
  void logout() async {
    final store = injector.get<LoginStore>();

    store.state.value = AppState.loading();

    final FirebaseAuth _authServiceauth = FirebaseAuth.instance;

    await _authServiceauth.signOut();
    store.didCheckAuth = false;
    checkAuth();
  }

  Future<void> checkAuth() async {
    final store = injector.get<LoginStore>();
    User? user;
    store.state.value = AppState.loading();


    store.firebaseAuth.value.authStateChanges().listen((User? userInital) {
      user = ((userInital == null) ? null : userInital);
    });

    if (store.firebaseAuth.value.currentUser == null) {
      LoginModule.to.navigator.pushNamed(LoginPage.routeName);
      Future.delayed(Duration(seconds: 3), () {
        store.state.value = AppState.error();
      });

      store.state.value = AppState.error();
    } else {
      LoginModule.to.navigator.pushNamed(HomePage.routeName);

      Future.delayed(Duration(seconds: 3), () {
        store.state.value = AppState.success();
      });
    }
  }

  Future<void> signinLoginUserFirebase() async {
    final SignInLoginUseCase signInLoginUseCase =
        injector.get<SignInLoginUseCase>();
    final store = injector.get<LoginStore>();
    store.state.value = AppState.loading();

    final response = await signInLoginUseCase.signinLogin(
        password: store.passwordText, email: store.emailText);

    response.fold((failure) {
      Future.delayed(Duration(seconds: 3), () {
        store.state.value = AppState.error();
      });
      ScaffoldMessenger.of(store.context!)
          .showSnackBar(SnackBar(content: Text(failure.message)));
      return;
    }, (sucess) {
      store.didCheckAuth = false;

      return checkAuth();
    });
  }
}
