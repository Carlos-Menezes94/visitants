import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:visitants/app/recover_password/data/datasources/recover_password_data_source_impl.dart';
import 'package:visitants/core/firebase_options.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  final mockFirebaseAuth = MockFirebaseAuth();
  final dataSource = RecoverPasswordDataSourceImpl();

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  });

  test('should recover password successfully', () async {
    when(() =>
            mockFirebaseAuth.sendPasswordResetEmail(email: any(named: 'email')))
        .thenAnswer((_) async {});

    final result = await dataSource.recoverPassword(email: 'email@gmail.com');

    expect(result.success, true);
    expect(result.data, '');
  });
}
