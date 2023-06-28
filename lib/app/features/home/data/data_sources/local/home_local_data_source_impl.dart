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
    final response =
        await localStorage.recoverDirectory(directory: VisitorModel.hiveBoxKey);
    int idKey = response.length + 1;

    await localStorage.insertData(
        directory: 'box_date_time_last_update',
        data: DateTime.now().toString(),
        key: 'lastDateTimeUpdate');
// // 
//     final boxDateTimeLastUpdate =
//         await Hive.openBox('box_date_time_last_update');

//     await boxDateTimeLastUpdate.put('lastDateTimeUpdate', DateTime.now());

    final box = await localStorage.insertData(
      directory: VisitorModel.hiveBoxKey,
      key: idKey.toString(),
      data: visitorData,
    );

    return DataSourceResponse(success: true, data: box);
  }

  @override
  Future<DataSourceResponse<List>> getListVisitorsLocal() async {
    // final collectionVisitorsTable =
    //     FirebaseFirestore.instance.collection('tabela_pessoas');
    // final docRef = collectionVisitorsTable.doc('cadastrados');

    // final response = await docRef.get();

    final response =
        await localStorage.recoverDirectory(directory: 'model_visitors');
    if (response.isNotEmpty) {
      return DataSourceResponse<List>(success: true, data: response);
    } else {
      return DataSourceResponse(success: false, data: response);
    }
  }
}
