import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto/pages/homeDash/homedashboard.dart';
import 'package:proto/pages/login/loginForm.dart';
import 'package:proto/pages/login/loginOrSignup.dart';
import 'package:proto/pages/ordersPage/ordersList.dart';
import 'package:proto/pages/startup/logopage.dart';
import 'package:proto/pages/profile.dart';
import 'package:proto/pages/registrationForm/registerStepper.dart';
import 'package:proto/pages/registrationOLD/register.dart';
import 'package:proto/pages/sendMoney/contctList.dart';
import 'package:proto/pages/sendMoney/enteramount.dart';
import 'package:proto/pages/sendMoney/enterphoneNumber.dart';
import 'package:proto/pages/sendMoney/pinentrypage.dart';
import 'package:proto/pages/services/blConsoltants.dart';
import 'package:proto/pages/services/blPage.dart';
import 'package:proto/pages/services/blVets.dart';
import 'package:proto/pages/services/blVetsCalls.dart';
import 'package:proto/pages/buyerpages/categoriesList.dart';
import 'package:proto/pages/buyerpages/ProductDetails.dart';
import 'package:proto/pages/sellerpages/stockList.dart';
import 'package:proto/pages/transactionPage.dart';
import 'package:proto/providers/addproductProvider.dart';
import 'package:proto/providers/loginProvider.dart';
import 'package:proto/providers/stepperFormProvider.dart';
import 'package:proto/pages/sellerpages/newProducts.dart';
import 'package:proto/pages/buyerpages/productsList.dart';
import 'package:proto/widgets/tab_controler.dart';
import 'package:proto/widgets/youtubeWebView.dart';
import 'package:provider/provider.dart';
import 'package:proto/pages/wallet/walletsTab.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    print(args);
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (ctx) => LogoPage());
      case '/startup':
        return MaterialPageRoute(builder: (ctx) => LoginOrSignup());
      case '/login':
        return MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider<LoginFormProvider>(
                create: (context) => LoginFormProvider(),
                child: LoginFormPage()));
      case '/addProduct':
        return CupertinoPageRoute(
            builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.dark,
                      systemNavigationBarColor: Colors.white),
                  child: ChangeNotifierProvider<AddProductFormProvider>(
                    create: (context) => AddProductFormProvider(),
                    child: AddProductsPage(
                      initalProduct: args,
                    ),
                  ),
                ));
      case '/home':
        return CupertinoPageRoute(
            builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.white),
                child: ChangeNotifierProvider<AddProductFormProvider>(
                    create: (context) => AddProductFormProvider(),
                    child: BaseTabView())));
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
        return CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => ChangeNotifierProvider<KraFormProvider>(
                create: (context) => KraFormProvider(),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        systemNavigationBarColor: Colors.white),
                    child: ContactsListPage())));
      case '/enterphone':
        return MaterialPageRoute(builder: (ctx) => EnterPhoneNumberPage());
      case '/pin':
        return MaterialPageRoute(builder: (ctx) => EnterPinPage());
      case '/enteramount':
        return MaterialPageRoute(builder: (ctx) => EnterAmountPage());
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
      case '/sellpage':
        return MaterialPageRoute(builder: (ctx) => InventoryList());
      case '/pdetails':
        return CupertinoPageRoute(builder: (ctx) => ProductDetails(p: args));
      case '/products':
        return MaterialPageRoute(builder: (ctx) => ProductList());
      case '/register':
        return MaterialPageRoute(builder: (ctx) => RegisterPage());
      case '/categories':
        return MaterialPageRoute(builder: (ctx) => ListTilezz());
      case '/dashboard':
        return MaterialPageRoute(
            builder: (ctx) => SmallerTextFactor(DashboardPage()));
      case '/orders':
        return MaterialPageRoute(
            builder: (ctx) => SmallerTextFactor(OrdersList()));
      case '/profile':
        return MaterialPageRoute(builder: (ctx) => ProfilePage());
      case '/walletspage':
        return MaterialPageRoute(builder: (ctx) => WalletsTab());
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

class SmallerTextFactor extends StatelessWidget {
  const SmallerTextFactor(this.child, {Key key}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      child: child,
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
    );
  }
}
