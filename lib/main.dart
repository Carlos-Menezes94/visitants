import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:visitants/app/features/home/presentation/home_module.dart';

import 'package:visitants/module/module_app.dart';

import 'app/depedency_injector/depedency_injector.dart';
import 'app/features/login/presentation/login_module.dart';
import 'app/features/login/presentation/pages/login_page.dart';
import 'core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // DepedencyInjector.start();

  runApp(ModuleApp(
    mainModule: LoginModule(),
    childModules: [
      HomeModule(),
    ],
    app: (home) => MyApp(home: home),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.home,
  }) : super(key: key);
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: home,
    );
  }
}
