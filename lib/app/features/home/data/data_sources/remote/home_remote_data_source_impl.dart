import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/core/response.dart';

import 'home_remote_data_source_abstract.dart';

class HomeDataSourceImpl implements HomeRemoteDataSourceAbstract {
  @override
  Future<DataSourceResponse> registerNewVisitor(
      VisitorModel visitorData) async {
    final CollectionReference collectionVisitorsTable =
        FirebaseFirestore.instance.collection('tabela_pessoas');
    DocumentReference docRef = collectionVisitorsTable.doc("cadastrados");

    // final documentSnapshot = await docRef.get();

    // if (documentSnapshot.exists) {
    //   List<dynamic> listVisitors = documentSnapshot.get('lista');

    //   for (var visitor in listVisitors) {
    //     if (visitor['cpf'] == visitorData.cpf) {
    //       return DataSourceResponse(
    //           success: false, data: "Visitante já existe na coleção");
    //     }
    //   }
    // }

    try {
      await docRef.update({
        'lista': FieldValue.arrayUnion([visitorData.toJson()])
      });

      return DataSourceResponse(success: true, data: "Sucesso");
    } catch (error) {
      return DataSourceResponse(
          success: false,
          data: throw Exception(
              '--------- Erro ao adicionar o novo item: $error ---------'));
    }
  }

  @override
  Future<DataSourceResponse> getListVisitors() async {
    final collectionVisitorsTable =
        FirebaseFirestore.instance.collection('tabela_pessoas');
    final docRef = collectionVisitorsTable.doc('cadastrados');

    final response = await docRef.get();

    if (response.exists) {
      return DataSourceResponse(success: true, data: response);
    } else {
      return DataSourceResponse(success: false, data: response);
    }
  }
}
