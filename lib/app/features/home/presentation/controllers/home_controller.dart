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

  void showContacts() async {
    const url = 'content://com.android.contacts/contacts';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void showWhatsApp() async {
    const url = 'content://com.android.contacts/contacts';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
