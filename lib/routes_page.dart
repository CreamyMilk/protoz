import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto/pages/blConsoltants.dart';
import 'package:proto/pages/blPage.dart';
import 'package:proto/pages/blVets.dart';
import 'package:proto/pages/blVetsCalls.dart';
import 'package:proto/pages/buySellPage.dart';
import 'package:proto/pages/categoriesList.dart';
import 'package:proto/pages/ProductDetails.dart';
import 'package:proto/pages/stockList.dart';
import 'package:proto/pages/logopage.dart';
import 'package:proto/pages/newProducts.dart';
import 'package:proto/pages/productsList.dart';
import 'package:proto/pages/register.dart';
import 'package:proto/pages/seeds.dart';
import 'package:proto/pages/walletsliver.dart';
import 'package:proto/loginPage.dart';
import 'package:proto/widgets/youtubeWebView.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    //final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (ctx) => LogoPage());
      case '/login':
        return MaterialPageRoute(
            builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.white),
                child: MyHomePage(title: "I")));

      case '/buysell':
        return MaterialPageRoute(builder: (ctx) => BuySellPage());
      case '/youtube':
        return MaterialPageRoute(builder: (ctx) => YoutubeWebView());
      case '/bl':
        return MaterialPageRoute(builder: (ctx) => BLPage());
      case '/blconsoltants':
        return MaterialPageRoute(builder: (ctx) => BLConsoltantsList());
      case '/blvets':
        return MaterialPageRoute(builder: (ctx) => BlVets());
      case '/vetsCalls':
        return MaterialPageRoute(builder: (ctx) => BlVetsCall());
      case '/addProduct':
        return MaterialPageRoute(builder: (ctx) => AddProductsPage());
      case '/sellpage':
        return MaterialPageRoute(builder: (ctx) => InventoryList());
      case '/pdetails':
        return CupertinoPageRoute(builder: (ctx) => ProductDetails());
      case '/products':
        return MaterialPageRoute(builder: (ctx) => ProductList());
      case '/register':
        return MaterialPageRoute(builder: (ctx) => RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (ctx) => WalletsPageBase());
      case '/categories':
        return MaterialPageRoute(builder: (ctx) => ListTilezz());
      case '/buyer':
        return MaterialPageRoute(builder: (ctx) => WalletsPageBase());
      case '/ferter':
        return MaterialPageRoute(builder: (ctx) => ProductDetails());
      case '/seds':
        return MaterialPageRoute(builder: (ctx) => SeedsExpansion());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
