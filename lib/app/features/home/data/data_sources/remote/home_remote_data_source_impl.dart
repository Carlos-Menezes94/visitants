import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
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

    await docRef.update({
      'lista': FieldValue.arrayUnion([visitorData.toJson()]),
      'lastFirestoreUpdate': DateTime.now().toString()
    });

    return DataSourceResponse(success: true, data: "");
    // try {
    //   await docRef.update({
    //     'lista': FieldValue.arrayUnion([visitorData.toJson()]),
    //     'lastFirestoreUpdate': DateTime.now().toString()
    //   });

    //   return DataSourceResponse(success: true, data: "Sucesso");
    // } catch (error) {
    //   return DataSourceResponse(
    //       success: false,
    //       data: throw Exception(
    //           '--------- Erro ao adicionar o novo item: $error ---------'));
    // }
  }

  @override
  Future<DataSourceResponse> getListVisitors() async {
    // final boxDateTimeLastUpdate =
    //     await Hive.openBox('box_date_time_last_update');
    // final responseHiveDateTimeLastUpdate =
    //     await boxDateTimeLastUpdate.get('lastDateTimeUpdate');

    final collectionVisitorsTable =
        FirebaseFirestore.instance.collection('tabela_pessoas');
    final docRef = collectionVisitorsTable.doc('cadastrados');

    final response = await docRef.get();

    List<Map<String, dynamic>> listOfMaps =
        response['lista'].cast<Map<String, dynamic>>();

    final box = await Hive.openBox(VisitorModel.hiveBoxKey);

    const uuid = Uuid();
    //Limpa o box que contém os dados dos visitantes cadastrados
    await box.clear();
    for (var map in listOfMaps) {
      VisitorModel visitor = VisitorModel.fromJson(map);
      String uniqueKey = uuid.v4(); // Gerar um UUID como chave única
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
      return DataSourceResponse(success: false, data: response);
    }
  }
}
