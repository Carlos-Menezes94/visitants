// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:visitants/app/features/login/data/data_sources/login_data_source_impl.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// void main() {
//   late LoginDataSourceImpl loginDataSource;
//   late MockFirebaseAuth mockFirebaseAuth;

//   setUp(() {
//     mockFirebaseAuth = MockFirebaseAuth();
//     loginDataSource = LoginDataSourceImpl(mockFirebaseAuth);
//   });

//   test('signInLogin - Sucesso na autenticação', () async {
//     // Mock do retorno do método signInWithEmailAndPassword
//     final mockUserCredential = MockUserCredential();
//     final mockUser = MockUser();
//     when(mockUserCredential.user).thenReturn(mockUser);
//     when(mockFirebaseAuth.signInWithEmailAndPassword(
//             email: 'email', password: 'password'))
//         .thenAnswer((_) async => mockUserCredential);

//     // Chamar o método signInLogin e verificar o resultado
//     final response = await loginDataSource.signInLogin(
//         email: 'test@example.com', password: 'password');

//     expect(response.success, true);
//     expect(response.data, mockUser);
//   });

//   test('signInLogin - Falha na autenticação', () async {
//     // Mock do retorno do método signInWithEmailAndPassword
//     final mockUserCredential = MockUserCredential();
//     when(mockUserCredential.user).thenReturn(null);
//     when(mockFirebaseAuth.signInWithEmailAndPassword(
//             email: 'email', password: 'password'))
//         .thenAnswer((_) async => mockUserCredential);

//     // Chamar o método signInLogin e verificar o resultado
//     final response = await loginDataSource.signInLogin(
//         email: 'test@example.com', password: 'password');

//     expect(response.success, false);
//     expect(response.data, null);
//   });
// }

// class MockUserCredential extends Mock implements UserCredential {}

// class MockUser extends Mock implements User {}
