import 'package:flutter/material.dart';
import 'package:proto/routes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Polo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 0.75,
              fontSizeDelta: 1.0,
            ),
        primaryColor: Colors.blue[900],
        accentColor: Colors.black54,
      ),
      darkTheme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 0.75,
              fontSizeDelta: 1.0,
            ),
        primaryColor: Colors.teal,
        accentColor: Colors.amber,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}