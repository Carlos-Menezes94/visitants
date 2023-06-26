import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/core/local_storage/local_storage_services.dart';
import 'package:visitants/core/response.dart';

import 'home_local_data_source_abstract.dart';

class HomeLocalDataSourceImpl implements HomeLocalDataSourceAbstract {
   final LocalStorageService localStorage;

  HomeLocalDataSourceImpl({required this.localStorage});

  @override
  Future<DataSourceResponse> registerNewVisitorHive(
      VisitorModel visitorData) async {
    final box = await localStorage.insertData(
        directory: 'model_visitors', key: 'visitors', data: visitorData);

        return DataSourceResponse(success: true, data: box);
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
