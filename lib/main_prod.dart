import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitants/app/features/home/presentation/home_module.dart';
import 'package:visitants/module/module_app.dart';
import 'app/features/login/presentation/login_module.dart';
import 'app/features/recover_password/presentation/recover_password_module.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://8d0e5e6aa04d4f929f297e8eff576675@o4505518017150976.ingest.sentry.io/4505518018461696';

      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(ModuleApp(
      mainModule: LoginModule(),
      childModules: [
        HomeModule(),
        RecoverPasswordModule(),
      ],
      app: (home) => MyApp(home: home),
    )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.home,
  }) : super(key: key);
  final Widget home;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.montserrat(textStyle: textTheme.labelLarge),
        ),
      ),
      home: home,
    );
  }
}
