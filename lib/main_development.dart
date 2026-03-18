import 'package:elfulk/src/core/config/firebase/firebase_options_development.dart';
import 'package:elfulk/src/app/boot/boot_app.dart';
import 'package:elfulk/src/core/config/app_environment.dart';

Future<void> main() async {
  await bootApp(
    flavor: AppFlavor.development,
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
}
