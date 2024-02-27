import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskify/login.dart';
import 'homepage.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Widget> pageChooser() async {
  if (FirebaseAuth.instance.currentUser != null) {
    return HomePage();
  } else {
    return LoginPage();
  }
}

// Navigation Variables
var page;
final navigatorKey = GlobalKey<NavigatorState>();

// Color Values
const mainColor = Color.fromARGB(255, 173, 216, 230);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  page = await pageChooser();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: page,
    );
  }
}
