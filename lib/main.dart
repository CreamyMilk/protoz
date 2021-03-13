import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proto/routes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        accentColor: Colors.tealAccent[800],
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
