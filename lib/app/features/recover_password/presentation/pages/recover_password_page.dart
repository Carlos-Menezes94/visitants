import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitants/core/state.dart';

import '../controllers/recover_password_controller.dart';
import '../recover_password_module.dart';
import '../stores/recover_password_store.dart';

class RecoverPasswordPage extends StatefulWidget {
  static const String routeName = '/RecoverPasswordPage';

  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends StatePage<RecoverPasswordModule,
    RecoverPasswordPage, RecoverPasswordController, RecoverPasswordStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recuperação de Senha")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Text(
            "Esqueceu sua senha? Não se preocupe! Estamos aqui para ajudar você a recuperar o acesso à sua conta. \n \nInsira o endereço de e-mail associado à sua conta",
            style: GoogleFonts.montserrat(),
          ),
          const SizedBox(height: 40),
          TextField(
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 80),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Enviar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
