import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:visitants/core/failure.dart';

import '../../domain/failures/cant_realize_of_login_failure.dart';
import '../../domain/failures/cant_realize_of_logout_failure.dart';
import '../../domain/repositories/login_reposiutory_abstract.dart';
import '../data_sources/login_data_source_impl.dart';

class LoginRepositoryImpl implements LoginRepositoryAbstract {
  final LoginDataSourceImpl dataSource;

  LoginRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, String>> logoutLogin() async {
    try {
      final response = await dataSource.logoutLogin();
      if (response.success) {
        return Right(response.data);
      } else {
        return Left(CantRealizeOfLogoutFailure());
      }
    } catch (error) {
      return Left(CantRealizeOfLogoutFailure());
    }
  }

  @override
  Future<Either<Failure, String>> registerLogin(
      {required String password, required String email}) async {
    // TODO: implement logoutLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signInLogin(
      {required String password, required String email}) async {
    try {
      final response =
          await dataSource.signInLogin(password: password, email: email);

      if (response.success) {
        return Right(response.data);
      } else {
        return Left(CantRealizeOfLoginFailure());
      }
    } catch (e) {
      return Left(CantRealizeOfLoginFailure());
    }
  }

  @override
  Future<Either<Failure, User>> socialLogin() async {
    try {
      final googleUser = await dataSource.socialLogin();

      final googleAuth = await googleUser.data.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;
      return Right(user!);
    } catch (error) {
      return Left(CantRealizeOfLoginFailure());
    }
  }
}
