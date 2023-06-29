import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Visitantes cadastrados",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ValueListenableBuilder<List<VisitorModel>>(
        valueListenable: controller.store.listVisitor,
        builder: (context, state, child) {
          if (store.state.value.hasError()) {
            const Center(child: Text("Lista vazia"));
          }
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
                                visitor.name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          },
                          body: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CPF: ${visitor.cpf}'),
                                Text('Apt visitado: ${visitor.apVisited}'),
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
