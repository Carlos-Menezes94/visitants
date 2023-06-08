import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visitants/app/features/home/presentation/home_module.dart';
import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import 'package:visitants/app/features/login/presentation/login_module.dart';
import 'package:visitants/app/features/visitor_registration/presentation/pages/visitor_registration_page.dart';
import 'package:visitants/core/state.dart';

import '../../../../../core/app_state.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState
    extends StatePage<HomeModule, HomePage, HomeController, HomeStore> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('EEEE, HH:mm', 'pt_BR').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              LoginModule.to.actions.logout();
            },
          )
        ],
      ),
      body: ValueListenableBuilder<AppState>(
          valueListenable: controller.store.state,
          builder: (context, state, child) {
            if (state.isLoading()) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Olá, ${controller.loginStore.firebaseAuth.value.currentUser!.email}"),
                      Text(formattedDateTime),
                    ],
                  ),
                  SizedBox(height: 100),
                  Container(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VisitorRegistrationPage()),
                        );
                      },
                      child: Text("Cadastrar visitante"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Visitantes cadastrados"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Ligar para morador"),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
    ;
  }
}
