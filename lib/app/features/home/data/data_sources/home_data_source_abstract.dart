import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/core/response.dart';

abstract class HomeDataSourceAbstract {
  Future registerNewVisitor(VisitorModel visitor);
  Future<DataSourceResponse> getListVisitors();
}
