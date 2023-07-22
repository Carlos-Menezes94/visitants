import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitants/app/login/presentation/pages/login_page.dart';
import 'package:visitants/app/login/presentation/stores/login_store.dart';
import '../../../../core/app_state.dart';
import '../../../../module/quick_actions.dart';
import '../../../../utils/toast.dart';
import '../../home/presentation/pages/home_page.dart';
import '../domain/usecases/signin_login_use_case.dart';
import 'login_module.dart';

class LoginQuickActions extends QuickActions<LoginModule> {
  void logout() async {
    final store = injector.get<LoginStore>();

    store.state.value = AppState.loading();

    final FirebaseAuth authServiceauth = FirebaseAuth.instance;

    await authServiceauth.signOut();
    store.didCheckAuth = false;
    checkAuth();
  }

  Future<void> checkAuth() async {
    final store = injector.get<LoginStore>();
    store.state.value = AppState.loading();

    store.firebaseAuth.value.authStateChanges().listen((User? userInital) {});
    if (store.isSplashScreenView.value) {
      store.state.value = AppState.idle();
      await Future.delayed(const Duration(seconds: 4));
      store.isSplashScreenView.value = false;
    }
    if (store.firebaseAuth.value.currentUser == null) {
      LoginModule.to.navigator.pushNamed(LoginPage.routeName);
      Future.delayed(const Duration(seconds: 3), () {
        store.state.value = AppState.error();
      });

      store.state.value = AppState.error();
    } else {
      LoginModule.to.navigator.pushNamed(HomePage.routeName);

      Future.delayed(const Duration(seconds: 2), () {
        store.state.value = AppState.success();
      });
    }
  }

  Future<void> signinLoginUserFirebase(BuildContext context) async {
    final SignInLoginUseCase signInLoginUseCase =
        injector.get<SignInLoginUseCase>();
    final store = injector.get<LoginStore>();
    store.state.value = AppState.loading();

    final response = await signInLoginUseCase.signinLogin(
        password: store.passwordText, email: store.emailText.trim());

    response.fold((failure) {
      store.state.value = AppState.error();

      return ToastHandler().showMyCustomToast(
        isStateSucess: false,
        context,
        text: failure.message,
      );
    }, (sucess) {
      store.didCheckAuth = false;
      disposeLogin();
      return checkAuth();
    });
  }

  void disposeLogin() {
    final store = injector.get<LoginStore>();

    store.emailController.clear();
    store.passwordController.clear();
    store.passwordText = "";
    store.passwordText = "";
  }
}
