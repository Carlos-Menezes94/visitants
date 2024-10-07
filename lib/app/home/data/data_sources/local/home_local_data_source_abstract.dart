import 'package:visitants/core/response.dart';

import '../../models/visitor_model.dart';

abstract class HomeLocalDataSourceAbstract {
  Future registerNewVisitorHive(VisitorModel visitor);
  Future<DataSourceResponse> getListVisitorsLocal();
}
