import 'package:dartz/dartz.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:visitants/core/response.dart';
import '../../../../../core/failure.dart';
import '../../../user_registration/data/models/user_registered_data_model.dart';
import '../../domain/failures/cant_created_new_visitor_failure.dart';
import '../../domain/failures/cant_get_list_visitors_failure.dart';
import '../../domain/failures/list_is_empty_failure.dart';
import '../../domain/repositories/home_repository_abstract.dart';
import '../data_sources/local/home_local_data_source_impl.dart';
import '../data_sources/remote/home_remote_data_source_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/visitor_model.dart';

class HomeRepositoryImpl implements HomeRepositoryAbstract {
  final HomeRemoteDataSourceImpl dataSourceRemote;
  final HomeLocalDataSourceImpl dataSourceLocal;

  HomeRepositoryImpl(
      {required this.dataSourceRemote, required this.dataSourceLocal});
  @override
  Future<Either<Failure, String>> createdNewVisitor(
      {required VisitorModel visitor}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    final DataSourceResponse response;

    try {
      if (connectivityResult == ConnectivityResult.none) {
        response = await dataSourceLocal.registerNewVisitorHive(visitor);
      } else {
        response = await dataSourceRemote.registerNewVisitorFirestore(visitor);
      }
      if (response.success) {
        return Right(response.data.toString());
      } else {
        return Left(CantCreateNewVisitorFailure());
      }
    } catch (error) {
      return Left(CantCreateNewVisitorFailure());
    }
  }

  @override
  Future<Either<Failure, List<VisitorModel>>> getListVisitors() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    final DataSourceResponse response;

    try {
      if (connectivityResult == ConnectivityResult.none) {
        response = await dataSourceLocal.getListVisitorsLocal();
        final List<VisitorModel> visitors = response.data.cast<VisitorModel>();

        if (visitors.isNotEmpty) {
          return Right(visitors);
        } else {
          return Left(ListIsEmptyFailure());
        }
      } else {
        response = await dataSourceRemote.getListVisitors();
        List<VisitorModel> list = [];
        final data = response.data;
        final lista = data?['lista'] as List<dynamic>?;

        for (var item in lista!) {
          if (item is Map<String, dynamic>) {
            VisitorModel visitor = VisitorModel.fromJson(item);
            list.add(visitor);
          }
        }

        if (list.isNotEmpty) {
          return Right(list);
        } else {
          return Left(ListIsEmptyFailure());
        }
      }
    } catch (error) {
      await Sentry.captureException(error);

      return Left(CantGetListVisitorsFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> adminCheckInRepository(
      {required String emailAdmin}) async {
    try {
      bool isCheckInVerify = false;
      final response = await dataSourceRemote.adminCheckInDataSource();
      print(response.data['lista']);
      String desiredEmail = "uuuuuu@gmail.com";

      // final listOfMaps = response.data['lista'].cast<Map<String, dynamic>>();
      List<UserRegisteredDataModel> users = response.data['lista']
          .map<UserRegisteredDataModel>(
              (item) => UserRegisteredDataModel.fromJson(item))
          .toList();

      // // Encontre o primeiro elemento com isAdmin == true
      // UserRegisteredDataModel? adminUser =
      //     users.firstWhere((element) => element.isAdminUser!);

      if (users.isNotEmpty) {
        // Se encontrou o usuário com o e-mail desejado, verificar se é administrador
        UserRegisteredDataModel? user = users.firstWhere(
            (user) => user.email == desiredEmail.trim(),
          );
        if (user != null) {
           isCheckInVerify = user.isAdminUser!;
          print(
              'O usuário com e-mail $desiredEmail é um administrador? $isCheckInVerify');
        } else {
          print('Usuário com e-mail $desiredEmail não encontrado.');
        }
      } else {
        print('Lista de usuários vazia.');
      }

      // for (var element in listOfMaps) {
      //   if (element["email"].toString().contains(emailAdmin)) {
      //     response.data['lista'];
      //     return const Right(true);
      //   }
      // }
      return Right(isCheckInVerify);
    } catch (error) {
      return Left(throw UnimplementedError());
    }
  }
}
