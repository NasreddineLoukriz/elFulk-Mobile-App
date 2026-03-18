import 'package:elfulk/src/core/config/firebase/firebase_options_production.example.dart';
import 'package:elfulk/src/app/boot/boot_app.dart';
import 'package:elfulk/src/core/config/app_environment.dart';

Future<void> main() async {
  await bootApp(
    flavor: AppFlavor.production,
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
}
