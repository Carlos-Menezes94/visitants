import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/app/features/home/presentation/home_module.dart';
import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import 'package:visitants/core/state.dart';

import '../controllers/home_controller.dart';

class ListVisitorPage extends StatefulWidget {
  static const String routeName = '/ListVisitorPage';

  const ListVisitorPage({Key? key}) : super(key: key);

  @override
  State<ListVisitorPage> createState() => ListVisitorPageState();
}

class ListVisitorPageState
    extends StatePage<HomeModule, ListVisitorPage, HomeController, HomeStore> {
  int expandedItemIndex = -1;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('EEEE, HH:mm', 'pt_BR').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ValueListenableBuilder<List<VisitorModel>>(
        valueListenable: controller.store.listVisitor,
        builder: (context, state, child) {
          return Scaffold(
            body: ListView.builder(
              itemCount: store.listVisitor.value.length,
              itemBuilder: (context, index) {
                final visitor = store.listVisitor.value[index];

                return ValueListenableBuilder(
                  valueListenable: controller.store.expandedItemIndex,
                  builder: (context, state, child) {
                    bool isExpanded = store.expandedItemIndex.value == index;

                    return ExpansionPanelList(
                      elevation: 1,
                      expansionCallback: (int panelIndex, bool isExpanded) {
                        store.expandedItemIndex.value = isExpanded ? -1 : index;
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                visitor.name,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            );
                          },
                          body: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CPF: ${visitor.cpf}'),
                                Text(
                                    'Apartamento visitado: ${visitor.apVisited}'),
                                Text('Placa do carro: ${visitor.carPlate}'),
                              ],
                            ),
                          ),
                          isExpanded: isExpanded,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
