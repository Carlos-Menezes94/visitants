import '../models/visitor_model.dart';

abstract class VisitorRegistrationDataSourceAbstract {
  Future registerNewVisitor(VisitorModel pessoa);
}
