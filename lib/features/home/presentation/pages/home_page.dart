import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visitants/features/visitor_registration/presentation/pages/visitor_registration_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('EEEE, HH:mm', 'pt_BR').format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Home")],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Olá, Usuário"),
                Text(formattedDateTime),
              ],
            ),
             SizedBox(height: 100),
            Container(
              height: 40,
              child: Expanded(
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
            ),
            const SizedBox(height: 16),
            Container(
              height: 40,
              child: Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Visitantes cadastrados"),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 40,
              child: Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Ligar para morador"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
