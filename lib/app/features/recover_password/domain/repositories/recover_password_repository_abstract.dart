import 'package:dartz/dartz.dart';

import '../../../../../core/failure.dart';

abstract class RecoverPasswordRepositoryAbstract {
  Future<Either<Failure, dynamic>> recoverPasswordRepository({required String email});
}
