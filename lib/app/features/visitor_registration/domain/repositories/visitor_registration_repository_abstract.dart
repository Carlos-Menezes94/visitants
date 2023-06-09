import 'package:dartz/dartz.dart';

import '../../../../../core/failure.dart';
import '../../data/models/visitor_model.dart';

abstract class VisitorRegistrationRepositoryAbstract {
  Future<Either<Failure, VisitorModel>> createdNewVisitor(
      {required VisitorModel visitor});
}
