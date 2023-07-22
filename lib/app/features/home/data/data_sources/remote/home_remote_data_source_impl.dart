import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/core/response.dart';

import '../../../../../../core/local_storage/local_storage_services.dart';
import '../local/home_local_data_source_impl.dart';
import 'home_remote_data_source_abstract.dart';
import 'package:uuid/uuid.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceAbstract {
  final HomeLocalDataSourceImpl homeLocalDataSourceImpl;
  final LocalStorageService localStorage;

  HomeRemoteDataSourceImpl(
      {required this.homeLocalDataSourceImpl, required this.localStorage});

  @override
  Future<DataSourceResponse> registerNewVisitorFirestore(
      VisitorModel visitorData) async {
    final CollectionReference collectionVisitorsTable =
        FirebaseFirestore.instance.collection('tabela_pessoas');
    DocumentReference docRef = collectionVisitorsTable.doc("cadastrados");
    docRef.update({
      'lista': FieldValue.arrayUnion([visitorData.toJson()]),
      'lastFirestoreUpdate': DateTime.now().toString()
    });

    return DataSourceResponse(success: true, data: "");
  }

  @override
  Future<DataSourceResponse> getListVisitors() async {
    final collectionVisitorsTable =
        FirebaseFirestore.instance.collection('tabela_pessoas');
    final docRef = collectionVisitorsTable.doc('cadastrados');

    final response = await docRef.get();

    List<Map<String, dynamic>> listOfMaps =
        response['lista'].cast<Map<String, dynamic>>();

    final box = await Hive.openBox(VisitorModel.hiveBoxKey);

    const uuid = Uuid();

    await box.clear();
    for (var map in listOfMaps) {
      VisitorModel visitor = VisitorModel.fromJson(map);
      String uniqueKey = uuid.v4();
      await box.put(uniqueKey, visitor);
    }

    // if (responseHiveDateTimeLastUpdate == null ||
    //     DateTime.parse(response['lastFirestoreUpdate'])
    //             .difference(responseHiveDateTimeLastUpdate)
    //             .inMinutes >
    //         5) {
    //   // Atualizar o Hive com os dados do Firestore
    //   List<Map<String, dynamic>> listOfMaps =
    //       response['lista'].cast<Map<String, dynamic>>();

    //   final box = await Hive.openBox(VisitorModel.hiveBoxKey);

    //   const uuid = Uuid();
    //   //Limpa o box que contém os dados dos visitantes cadastrados
    //   await box.clear();
    //   for (var map in listOfMaps) {
    //     VisitorModel visitor = VisitorModel.fromJson(map);
    //     String uniqueKey = uuid.v4(); // Gerar um UUID como chave única
    //     await box.put(uniqueKey, visitor);
    //   }

    //   // Atualizar o valor do lastDateTimeUpdate no Hive
    //   await boxDateTimeLastUpdate.put(
    //       'lastDateTimeUpdate', response['lastFirestoreUpdate']);
    // }

    if (response.exists) {
      return DataSourceResponse(success: true, data: response);
    } else {
      await Sentry.captureException(response.data);

      return DataSourceResponse(success: false, data: response);
    }
  }

    @override
  Future<DataSourceResponse> adminCheckInDataSource() async {
    final collectionVisitorsTable =
        FirebaseFirestore.instance.collection('users');
    final docRef = collectionVisitorsTable.doc('zOKVMLCeOBD24Ucysx6D');

    final response = await docRef.get();

    if (response.exists) {
      return DataSourceResponse(success: true, data: response);
    } else {
      return DataSourceResponse(success: false, data: false);
    }
  }
}
