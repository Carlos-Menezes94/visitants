import 'package:dartz/dartz.dart';
import 'package:visitants/app/features/visitor_registration/data/models/visitor_model.dart';
import 'package:visitants/app/features/visitor_registration/data/repositories/visitor_registration_repository_impl.dart';

import '../../../../../core/failure.dart';

class CreateNewRegistrationVisitorUseCase {
  final VisitorRegistrationRepositoryImpl repository;

  CreateNewRegistrationVisitorUseCase({required this.repository});

  Future<Either<Failure, VisitorModel>> registerVisitor({required VisitorModel visitor}) async {
    return repository.createdNewVisitor(visitor: visitor);
  }
}
