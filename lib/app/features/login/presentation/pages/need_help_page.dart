import 'package:flutter/material.dart';
import 'package:visitants/core/state.dart';

import '../../../recover_password/presentation/pages/recover_password_page.dart';
import '../controllers/login_controller.dart';
import '../login_module.dart';
import '../stores/login_store.dart';

class NeedHelpPage extends StatefulWidget {
  static const String routeName = '/NeedHelpPage';

  const NeedHelpPage({super.key});

  @override
  State<NeedHelpPage> createState() => _NeedHelpPageState();
}

class _NeedHelpPageState
    extends StatePage<LoginModule, NeedHelpPage, LoginController, LoginStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Precisando de ajuda?")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: [
          const SizedBox(height: 200),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => LoginModule.to.navigator
                      .pushNamed(RecoverPasswordPage.routeName),
                  child: const Text(
                    "Esqueceu sua senha?",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Cadastrar novo usuario?",
                    style: TextStyle(color: Colors.black),
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
