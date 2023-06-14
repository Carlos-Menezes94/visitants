import 'package:dartz/dartz.dart';
import 'package:visitants/app/features/home/data/models/visitor_model.dart';
import 'package:visitants/app/features/home/data/repositories/home_repository_impl.dart';

import '../../../../../core/failure.dart';

class CreateNewRegistrationVisitorUseCase {
  final HomeRepositoryImpl repository;

  CreateNewRegistrationVisitorUseCase({required this.repository});

  Future<Either<Failure, String>> registerVisitor(
      {required VisitorModel visitor}) async {
    return repository.createdNewVisitor(visitor: visitor);
  }
}
