import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import 'package:visitants/app/features/login/presentation/stores/login_store.dart';
import 'package:visitants/core/controller.dart';

class HomeController extends Controller {
  final HomeStore store;
  final LoginStore loginStore;

  HomeController({required this.loginStore, required this.store});
}
