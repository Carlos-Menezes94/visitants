import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:visitants/core/state.dart';
import '../../../../../core/asset_loader.dart';
import '../controllers/login_controller.dart';
import '../login_module.dart';
import '../stores/login_store.dart';
import '../widgets/input_data_login_widget.dart';
import 'need_help_page.dart';

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

  // Future<void> _logout(BuildContext context) async {
  //   try {
  //     await GoogleSignIn().signOut();
  //     // Se você também estiver usando Firebase, pode adicionar FirebaseAuth.instance.signOut() aqui
  //     // FirebaseAuth.instance.signOut();
  //     // Limpar as informações de autenticação do usuário e navegar de volta para a tela de login ou a tela inicial do seu aplicativo.
  //     // Navigator.pushReplacementNamed(context, '/login'); // Exemplo de navegação para a tela de login
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Logout do Google realizado com sucesso.'),
  //       ),
  //     );
  //   } catch (error) {
  //     print('Erro ao fazer logout do Google: $error');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Erro ao fazer logout do Google. Tente novamente.'),
  //       ),
  //     );
  //   }
  // }

  bool showPassword = false;
  void _togglevisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      fit: BoxFit.cover,
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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      SizedBox(
                        height: 150,
                        child: Image.asset(
                          AssetLoader.logoBuildingImg,
                        ),
                      ),
                      const SizedBox(height: 70),
                      Form(
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
                              suffixIcon: null,
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
                              obscureText: showPassword,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _togglevisibility();
                                },
                                child: Icon(
                                  showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0XFFBCD6C8),
                                  size: 26,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SignInButton(
                              Buttons.google,
                              text: "Sign up with Google",
                              onPressed: () {
                                controller.loginSocial();
                                // _handleSignIn();
                              },
                              elevation: 2,
                            ),
                            const SizedBox(height: 60),
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                onPressed: () {
                                  LoginModule.to.actions
                                      .signinLoginUserFirebase(context);
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
                      const SizedBox(height: 70),
                      InkWell(
                        onTap: () {
                          LoginModule.to.navigator
                              .pushNamed(NeedHelpPage.routeName);
                        },
                        child: const Text("Precisa de ajuda?"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _logout(context);
                          },
                          child: child)
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      // Se você também estiver usando Firebase, pode adicionar FirebaseAuth.instance.signOut() aqui
      // FirebaseAuth.instance.signOut();
      // Limpar as informações de autenticação do usuário e navegar de volta para a tela de login ou a tela inicial do seu aplicativo.
      // Navigator.pushReplacementNamed(context, '/login'); // Exemplo de navegação para a tela de login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout do Google realizado com sucesso.'),
        ),
      );
    } catch (error) {
      print('Erro ao fazer logout do Google: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao fazer logout do Google. Tente novamente.'),
        ),
      );
    }
  }
}
