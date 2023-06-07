import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controllers/login_controller.dart';
import '../widgets/input_data_login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _controller = GetIt.I.get<LoginController>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _controller.closeKeyboardOnOutsideClick,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputDataLoginWidget(
                  labelText: "E-mail",
                  controller: _controller.store.emailController,
                  focusNode: _controller.store.focusNodeEmail,
                ),
                SizedBox(height: 20),
                InputDataLoginWidget(
                  labelText: "Senha",
                  controller: _controller.store.passwordController,
                  focusNode: _controller.store.focusNodePassword,
                ),
                SizedBox(height: 60),
                Container(
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {},
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
        ),
      ),
    );
  }
}
