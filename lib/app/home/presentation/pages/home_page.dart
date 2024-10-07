import 'package:flutter/material.dart';
import 'package:visitants/app/home/presentation/pages/visitor_registration_page.dart';
import 'package:visitants/app/user_registration/presentation/pages/user_registration_page.dart';
import 'package:visitants/core/state.dart';

import '../../../login/presentation/login_module.dart';
import '../controllers/home_controller.dart';
import '../home_module.dart';
import '../stores/home_store.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState
    extends StatePage<HomeModule, HomePage, HomeController, HomeStore> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.adminCheckIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
        )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              LoginModule.to.actions.logout(context);
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: controller.store.state,
          builder: (context, state, child) {
            if (state.isLoading()) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  return await controller.adminCheckIn();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Olá, seja bem-vindo!",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${controller.loginStore.firebaseAuth.value.currentUser!.email}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: store.isAdmin.value ? Colors.red : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 100),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            LoginModule.to.navigator
                                .pushNamed(VisitorRegistrationPage.routeName);
                          },
                          child: const Text(
                            "Cadastrar visitante",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.getListVisitor(context);
                          },
                          child: const Text(
                            "Visitantes cadastrados",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    content: const Text(
                                        'Escolha como deseja falar com morador'),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              store.isContactResidentWhatsApp =
                                                  true;
                                              controller.contactResident();
                                            },
                                            child: const Text('WhatsApp'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              store.isContactResidentWhatsApp =
                                                  false;
                                              controller.contactResident();
                                            },
                                            child: const Text('Ligação'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }));
                          },
                          child: const Text(
                            "Ligar para morador",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Offstage(
                        offstage: !store.isAdmin.value,
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              LoginModule.to.navigator
                                  .pushNamed(UserRegistrationPage.routeName);
                            },
                            child: const Text(
                              "Cadastrar novo usuário",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
