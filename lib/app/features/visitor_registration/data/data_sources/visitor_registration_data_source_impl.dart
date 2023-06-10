import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visitants/app/features/visitor_registration/data/data_sources/visitor_registration_data_source_abstract.dart';
import 'package:visitants/core/response.dart';
import '../models/visitor_model.dart';

class VisitorRegistrationDataSourceImpl
    implements VisitorRegistrationDataSourceAbstract {
  @override
  Future<DataSourceResponse> registerNewVisitor(
      VisitorModel visitorData) async {
    final CollectionReference collectionVisitorsTable =
        FirebaseFirestore.instance.collection('tabela_pessoas');
    DocumentReference docRef = collectionVisitorsTable.doc("cadastrados");

    DocumentSnapshot documentSnapshot = await docRef.get();

    if (documentSnapshot.exists) {
      List<dynamic> listVisitors = documentSnapshot.get('lista');

      for (var visitor in listVisitors) {
        if (visitor['cpf'] == visitorData.cpf) {
          return DataSourceResponse(
              success: false, data: "Visitante já existe na coleção");
        }
      }
    }

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
}
