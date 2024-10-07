import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:visitants/core/state.dart';

import '../../../../../core/asset_loader.dart';
import '../controllers/recover_password_controller.dart';
import '../recover_password_module.dart';
import '../stores/recover_password_store.dart';
import '../widgets/button_widget.dart';

class RecoverPasswordPage extends StatefulWidget {
  static const String routeName = '/RecoverPasswordPage';

  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends StatePage<RecoverPasswordModule,
    RecoverPasswordPage, RecoverPasswordController, RecoverPasswordStore> {
  final formKey = GlobalKey<FormState>();
  void submitForm1(BuildContext context) {
    if (formKey.currentState!.validate()) {
      controller.sendLinkRecoverPassword(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: store.state,
        builder: (context, state, child) {
          if (state.hasSuccess()) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Lottie.asset(
                      AssetLoader.sucessLottie,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(title: const Text("Recuperação de Senha")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(children: [
                  Text(
                    "Esqueceu sua senha? Não se preocupe! Estamos aqui para ajudar você a recuperar o acesso à sua conta. \n \nInsira o endereço de e-mail associado à sua conta.\nVocê receberá um e-mail com um link seguro para redefinir sua senha.",
                    style: GoogleFonts.montserrat(),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira um e-mail';
                      }
                      return null;
                    },
                    onChanged: (email) {
                      store.emailTextToRecoverPassword = email;
                    },
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  ButtonWidget(
                    onPressed: () {
                      submitForm1(context);
                    },
                  ),
                ]),
              ),
            ),
          );
        });
  }
}
