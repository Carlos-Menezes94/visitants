import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/core/response.dart';

abstract class HomeLocalDataSourceAbstract {
  Future registerNewVisitorHive(VisitorModel visitor);
  Future<DataSourceResponse> getListVisitorsLocal();
}
