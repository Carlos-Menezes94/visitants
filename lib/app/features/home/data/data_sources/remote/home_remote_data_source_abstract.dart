import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/core/response.dart';

abstract class HomeRemoteDataSourceAbstract {
  Future<DataSourceResponse> registerNewVisitor(VisitorModel visitor);
  Future<DataSourceResponse> getListVisitors();
}
