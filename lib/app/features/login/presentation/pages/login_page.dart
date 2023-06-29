import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visitants/app/features/login/presentation/login_module.dart';
import 'package:visitants/app/features/login/presentation/stores/login_store.dart';
import 'package:visitants/core/state.dart';

import '../../../../../core/asset_loader.dart';
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
    print('rebuild');
    return GestureDetector(
      onTap: controller.closeKeyboardOnOutsideClick,
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: controller.store.state,
            builder: (context, state, child) {
              if (state.isIdle()) {
                return Center(
                  child: SizedBox(
                    child: Lottie.asset(
                      AssetLoader.buildingLottie,
                      fit: BoxFit
                          .cover, // Define como a imagem deve ser ajustada ao espaço disponível
                    ),
                  ),
                );
              }
              if (state.isLoading()) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      InputDataLoginWidget(
                        labelText: "Senha",
                        controller: controller.store.passwordController,
                        focusNode: controller.store.focusNodePassword,
                        textTextField: (value) {
                          controller.store.passwordText = value;
                        },
                        textInputType: null,
                        obscureText: true,
                      ),
                      const SizedBox(height: 60),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            LoginModule.to.actions.signinLoginUserFirebase();
                          },
                          child: const Text(
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
