import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visitants/app/features/visitor_registration/data/data_sources/visitor_registration_data_source_abstract.dart';
import '../models/visitor_model.dart';

class VisitorRegistrationDataSourceImpl
    implements VisitorRegistrationDataSourceAbstract {

  @override
  Future registerNewVisitor(VisitorModel visitorData) async {
    final CollectionReference collectionVisitorsTable =
        FirebaseFirestore.instance.collection('tabela_pessoas');
    DocumentReference docRef = collectionVisitorsTable.doc("cadastrados");

    try {
      await docRef.update({
        'lista': FieldValue.arrayUnion([visitorData.toJson()])
      });
    } catch (error) {
      return throw Exception('--------- Erro ao adicionar o novo item: $error ---------');
    }
  }
}
