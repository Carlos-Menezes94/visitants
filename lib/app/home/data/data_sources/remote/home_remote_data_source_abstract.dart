import 'package:visitants/core/response.dart';

import '../../models/visitor_model.dart';

abstract class HomeRemoteDataSourceAbstract {
  Future<DataSourceResponse> registerNewVisitorFirestore(VisitorModel visitor);
  Future<DataSourceResponse> getListVisitors();
  Future<DataSourceResponse> adminCheckInDataSource();
}
