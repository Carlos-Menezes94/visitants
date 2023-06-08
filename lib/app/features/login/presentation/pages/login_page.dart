import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:visitants/app/features/login/presentation/login_module.dart';
import 'package:visitants/app/features/login/presentation/stores/login_store.dart';
import 'package:visitants/core/state.dart';

import '../../../../../core/app_state.dart';
import '../controllers/login_controller.dart';
import '../widgets/input_data_login_widget.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/LoginPage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState
    extends StatePage<LoginModule, LoginPage, LoginController, LoginStore> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.store.didCheckAuth) {
        controller.store.didCheckAuth = true;
        LoginModule.to.actions.checkAuth();
      }
      // LoginModule.to.actions.checkAuth();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.closeKeyboardOnOutsideClick,
      child: Scaffold(
        body: ValueListenableBuilder<AppState>(
            valueListenable: controller.store.state,
            builder: (context, state, child) {
              if (state.isLoading()) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InputDataLoginWidget(
                        labelText: "E-mail",
                        controller: controller.store.emailController,
                        focusNode: controller.store.focusNodeEmail,
                        textTextField: (value) {
                          controller.store.emailText = value;
                        },
                      ),
                      SizedBox(height: 20),
                      InputDataLoginWidget(
                        labelText: "Senha",
                        controller: controller.store.passwordController,
                        focusNode: controller.store.focusNodePassword,
                        textTextField: (value) {
                          controller.store.passwordText = value;
                        },
                      ),
                      SizedBox(height: 60),
                      Container(
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            LoginModule.to.actions.signinLoginUserFirebase();
                          },
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
