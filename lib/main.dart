
import 'package:e_branch/Screens/HomeScreens/HomeScreen.dart';
import 'package:e_branch/services/fcm_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'Helpers/Config.dart';
import 'Providers/Auth/AuthProvider.dart';
import 'Providers/Home/HomeProvider.dart';
import 'Screens/Splashscreen.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FCMService().setupFlutterNotifications();
  FCMService().showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final fcm = await FirebaseMessaging.instance.getToken();
  print('Token: $fcm');
  if (!kIsWeb) {
    await FCMService().setupFlutterNotifications();
  }
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
      ],
      child: OKToast(
        child: MaterialApp(
          title: 'E-Branch',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Config.mainColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(color: Colors.white,iconTheme: IconThemeData(color: Colors.white)),
          ),
          home:
         const Splashscreen(),
        ),
      ),
    );
  }
}
