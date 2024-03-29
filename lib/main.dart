import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proto/constants.dart';
import 'package:proto/routes_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  }
  await Hive.openBox(
    Constants.UserBoxName,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Agro|CRM';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.compact,
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColorLight: Colors.teal,
        primaryColorDark: Colors.teal,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
