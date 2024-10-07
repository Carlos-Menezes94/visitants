import 'package:dartz/dartz.dart';
import 'package:visitants/app/home/data/models/visitor_model.dart';
import '../../../../../core/failure.dart';
import '../../data/repositories/home_repository_impl.dart';

class CreateNewRegistrationVisitorUseCase {
  final HomeRepositoryImpl repository;

  CreateNewRegistrationVisitorUseCase({required this.repository});

  Future<Either<Failure, String>> registerVisitor(
      {required VisitorModel visitor}) async {
    return repository.createdNewVisitor(visitor: visitor);
  }
}
