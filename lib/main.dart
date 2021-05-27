import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:hive/hive.dart';
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
  await Hive.openBox(Constants.UserBoxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Agro|CRM';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: Colors.teal,
        accentColor: Colors.tealAccent,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
