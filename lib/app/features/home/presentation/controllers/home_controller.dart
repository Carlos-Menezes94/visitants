import 'package:url_launcher/url_launcher.dart';
import 'package:visitants/app/features/home/presentation/stores/home_store.dart';
import 'package:visitants/app/features/login/presentation/stores/login_store.dart';
import 'package:visitants/core/controller.dart';

class HomeController extends Controller {
  final HomeStore store;
  final LoginStore loginStore;

  HomeController({required this.loginStore, required this.store});

  void contactResident() {
    if (store.isContactResidentWhatsApp) {
      showWhatsApp();
    } else {
      showContacts();
    }
  }

  void showContacts() {
    final Uri uri = Uri(
      scheme: 'tel',
      path: '',
    );

    launch(uri.toString());
  }

  void showWhatsApp() async {
    String message = 'Olá, aqui é da portaria.';

    String url = 'https://wa.me/?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }
}
