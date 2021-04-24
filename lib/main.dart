import 'package:firebase_core/firebase_core.dart';

import 'constants.dart' as Constants;
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:proto/routes_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  await Hive.openBox(Constants.UserBoxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Agro|CRM';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: Colors.teal,
        // floatingActionButtonTheme:FloatingActionButtonThemeData(

        accentColor: Colors.tealAccent,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
