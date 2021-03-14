import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto/pages/bl/blConsoltants.dart';
import 'package:proto/pages/bl/blPage.dart';
import 'package:proto/pages/bl/blVets.dart';
import 'package:proto/pages/bl/blVetsCalls.dart';
import 'package:proto/pages/login/loginForm.dart';
import 'package:proto/pages/profile.dart';
import 'package:proto/pages/registration/register.dart';
import 'package:proto/pages/sendMoney/contctList.dart';
import 'package:proto/pages/startup/buySellPage.dart';
import 'package:proto/pages/buyerpages/categoriesList.dart';
import 'package:proto/pages/buyerpages/ProductDetails.dart';
import 'package:proto/pages/sellerpages/stockList.dart';
import 'package:proto/pages/startup/homePage.dart';
import 'package:proto/pages/stepperForm/registerStepper.dart';
import 'package:proto/pages/transactionPage.dart';
import 'package:proto/providers/stepperFormProvider.dart';
import 'package:proto/widgets/logopage.dart';
import 'package:proto/pages/sellerpages/newProducts.dart';
import 'package:proto/pages/buyerpages/productsList.dart';
import 'package:proto/widgets/tab_controler.dart';
import 'package:proto/pages/walletsliver.dart';
import 'package:proto/widgets/youtubeWebView.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    //final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (ctx) => LogoPage());
      case '/startup':
        return MaterialPageRoute(builder: (ctx) => HomePage());
      case '/login':
        return MaterialPageRoute(builder: (ctx) => LoginFormPage());
      case '/home':
        return CupertinoPageRoute(
            builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.white),
                child: BaseTabView()));
       case '/kraform':
        return MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider<KraFormProvider>(
                create: (context) => KraFormProvider(),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                        statusBarColor: Colors.teal[400],
                        systemNavigationBarColor: Colors.white),
                    child: BaseForm())));
      case '/contactList':
        return CupertinoPageRoute(builder: (ctx) => ContactsListPage());
      case '/buysell':
        return MaterialPageRoute(builder: (ctx) => BuySellPage());
      case '/transaction':
        return MaterialPageRoute(builder: (ctx) => TransactionClass());
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
      case '/categories':
        return MaterialPageRoute(builder: (ctx) => ListTilezz());
      case '/buyer':
        return MaterialPageRoute(builder: (ctx) => WalletsPageBase());
      case '/ferter':
        return MaterialPageRoute(builder: (ctx) => ProductDetails());

      case '/profile':
        return MaterialPageRoute(builder: (ctx) => ProfilePage());
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
