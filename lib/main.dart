import 'package:flutter/material.dart';
import 'homepage.dart';

Future<Widget> pageChooser() async {
  return const HomePage();
}

// Navigation Variables
var page;
final navigatorKey = GlobalKey<NavigatorState>();

// Color Values
const mainColor = Color.fromARGB(255, 173, 216, 230);

Future<void> main() async {
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
