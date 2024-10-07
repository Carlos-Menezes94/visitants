// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:test/test.dart';
// import 'package:visitants/core/response.dart';

// @GenerateMocks([GoogleSignIn, DataSource])
// void main() {
//   group('LoginRepositoryTest', () {
//     late MockGoogleSignIn mockGoogleSignIn;
//     late MockDataSource mockDataSource;
//     late Repository repository;

//     setUp(() {
//       mockGoogleSignIn = MockGoogleSignIn();
//       mockDataSource = MockDataSource();
//       repository = Repository(dataSource: mockDataSource);
//     });

//     test('successful login with Google', () async {
//       // Mock successful Google sign-in
//       final mockGoogleUser = GoogleSignInAccount(displayName: 'Test User');
//       when(mockGoogleSignIn.signIn())
//           .thenAnswer((_) => Future.value(mockGoogleUser));
//       when(mockDataSource.loginGoogle()).thenAnswer((_) => Future.value(
//           DataSourceResponse(success: true, data: mockGoogleUser)));

//       // Call the login function
//       final user = await repository._handleSignIn();

//       // Verify successful login and returned user
//       expect(user, isNotNull);
//       expect(user!.displayName, 'Test User');
//     });

//     test('login with Google fails', () async {
//       // Mock Google sign-in to return null
//       when(mockGoogleSignIn.signIn()).thenAnswer((_) => Future.value(null));
//       when(mockDataSource.loginGoogle()).thenAnswer(
//           (_) => Future.value(DataSourceResponse(success: false, data: null)));

//       // Call the login function
//       final user = await repository._handleSignIn();

//       // Verify no user is returned
//       expect(user, isNull);
//     });

//     test('error handling during login', () async {
//       // Mock an error during Google sign-in
//       final error = Exception('Failed to sign in with Google');
//       when(mockGoogleSignIn.signIn()).thenThrow(error);

//       // Call the login function and expect the error to be printed
//       await repository._handleSignIn();
//       verify(() => print(error)); // Verify that the error is printed
//     });
//   });
// }
