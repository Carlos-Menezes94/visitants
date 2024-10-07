import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitants/app/user_registration/data/data_sources/user_registration_data_source_abstract.dart';
import 'package:visitants/core/response.dart';

import '../models/user_registered_data_model.dart';

class UserRegistrationDataSourceImpl
    implements UserRegistrationDataSourceAbstract {
  @override
  Future<DataSourceResponse> newUserRegistration(
      {required UserRegisteredDataModel userRegisteredDataModel}) async {
    FirebaseAuth authFirebase = FirebaseAuth.instance;
    final response = await authFirebase.createUserWithEmailAndPassword(
        email: userRegisteredDataModel.email!,
        password: userRegisteredDataModel.password!);

    if (response.user != null) {
      final CollectionReference collectionVisitorsTable =
          FirebaseFirestore.instance.collection('users');
      DocumentReference docRef =
          collectionVisitorsTable.doc("zOKVMLCeOBD24Ucysx6D");
      await docRef.update({
        'lista': FieldValue.arrayUnion([userRegisteredDataModel.toJson()]),
      });

      return DataSourceResponse(success: true, data: response);
    } else {
      return DataSourceResponse(success: false, data: response);
    }
  }
}
