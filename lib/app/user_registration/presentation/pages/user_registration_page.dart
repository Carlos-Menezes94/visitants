import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visitants/app/login/presentation/login_module.dart';
import 'package:visitants/core/state.dart';

import '../../../../core/asset_loader.dart';
import '../controllers/user_registration_controller.dart';
import '../stores/user_registration_store.dart';
import '../user_registration_module.dart';

class UserRegistrationPage extends StatefulWidget {
  static const String routeName = '/UserRegistrationPage';

  const UserRegistrationPage({Key? key}) : super(key: key);

  @override
  State<UserRegistrationPage> createState() => UserRegistrationPageState();
}

class UserRegistrationPageState extends StatePage<UserRegistrationModule,
    UserRegistrationPage, UserRegistrationController, UserRegistrationStore> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      controller.createUserNew(context);
      // controller.registerNewVisitor(context);
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
            appBar: AppBar(
              title: const Text('Cadastro de novo usuário'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: LoginModule.to.navigator.pop,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.store.email,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '[Por favor, insira um e-mail]';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      // inputFormatters: [CPFMask.inputMask],
                      controller: controller.store.password,
                      decoration: const InputDecoration(labelText: 'Senha'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '[Por favor, insira uma senha]';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text(
                        'Enviar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
