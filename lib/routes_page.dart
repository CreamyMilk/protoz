import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto/models/product.dart';
import 'package:proto/pages/blPages/bl_consoltants.dart';
import 'package:proto/pages/blPages/bl_page.dart';
import 'package:proto/pages/blPages/bl_vets.dart';
import 'package:proto/pages/blPages/bl_vets_calls.dart';
import 'package:proto/pages/homeDash/homedashboard.dart';
import 'package:proto/pages/login/login_form.dart';
import 'package:proto/pages/login/login_or_signup.dart';
import 'package:proto/pages/ordersPage/orders_list.dart';
import 'package:proto/pages/past_purchases/past_purchase_list.dart';
import 'package:proto/pages/registrationForm/registration_stepper_page.dart';
import 'package:proto/pages/startup/logopage.dart';
import 'package:proto/pages/blPages/profile.dart';
import 'package:proto/pages/registrationForm/register_manual_stepper.dart';
import 'package:proto/pages/registrationOLD/register.dart';
import 'package:proto/pages/sendMoney/contct_list.dart';
import 'package:proto/pages/sendMoney/enteramount.dart';
import 'package:proto/pages/sendMoney/enterphone_number.dart';
import 'package:proto/pages/sendMoney/pinentrypage.dart';
import 'package:proto/pages/buyerpages/categories_list.dart';
import 'package:proto/pages/buyerpages/product_details.dart';
import 'package:proto/pages/sellerpages/stock_list.dart';
import 'package:proto/pages/transaction_page.dart';
import 'package:proto/providers/addproduct_provider.dart';
import 'package:proto/providers/login_provider.dart';
import 'package:proto/providers/stepper_form_provider.dart';
import 'package:proto/pages/sellerpages/new_products.dart';
import 'package:proto/pages/buyerpages/products_list.dart';
import 'package:proto/widgets/qr_scanner_button.dart';
import 'package:provider/provider.dart';
import 'package:proto/pages/wallet/wallets_tab.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final Object? args = settings.arguments;
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
        if (args != null) {
          return CupertinoPageRoute(
              builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
                  value: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.dark,
                      systemNavigationBarColor: Colors.white),
                  child: ChangeNotifierProvider<AddProductFormProvider>(
                      create: (context) => AddProductFormProvider(),
                      child: AddProductsPage(initalProduct: args as Product))));
        } else {
          return CupertinoPageRoute(
              builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
                  value: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.dark,
                      systemNavigationBarColor: Colors.white),
                  child: ChangeNotifierProvider<AddProductFormProvider>(
                      create: (context) => AddProductFormProvider(),
                      child: const AddProductsPage())));
        }
      case '/kraform':
        return MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider<KraFormProvider>(
                create: (context) => KraFormProvider(),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                        statusBarColor: Colors.teal[400],
                        systemNavigationBarColor: Colors.white),
                    child: const BaseForm())));
      case '/contactList':
        return CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => ChangeNotifierProvider<KraFormProvider>(
                create: (context) => KraFormProvider(),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        systemNavigationBarColor: Colors.white),
                    child: ContactsListPage())));
      case '/stepregister':
        return MaterialPageRoute(
            builder: (ctx) => const RegistrationStepperForm());
      case '/enterphone':
        return MaterialPageRoute(builder: (ctx) => EnterPhoneNumberPage());
      case '/qrscanner':
        return MaterialPageRoute(builder: (ctx) => const QRCodeScannerPage());
      case '/pastpurchases':
        return MaterialPageRoute(builder: (ctx) => const PastPurchasePage());
      case '/pin':
        return MaterialPageRoute(builder: (ctx) => const EnterPinPage());
      case '/enteramount':
        return MaterialPageRoute(builder: (ctx) => const EnterAmountPage());
      case '/transaction':
        return MaterialPageRoute(builder: (ctx) => const TransactionClass());
      case '/bl':
        return MaterialPageRoute(builder: (ctx) => const BLPage());
      case '/blconsoltants':
        return MaterialPageRoute(builder: (ctx) => const BLConsoltantsList());
      case '/blvets':
        return MaterialPageRoute(builder: (ctx) => BlVets());
      case '/vetsCalls':
        return MaterialPageRoute(builder: (ctx) => const BlVetsCall());
      case '/sellpage':
        return MaterialPageRoute(builder: (ctx) => InventoryList());
      case '/pdetails':
        if (args != null) {
          return CupertinoPageRoute(
              builder: (ctx) => ProductDetails(p: args as Product));
        } else {
          return _errorRoute();
        }
      case '/products':
        return MaterialPageRoute(builder: (ctx) => ProductList());
      case '/register':
        return MaterialPageRoute(builder: (ctx) => RegisterPage());
      case '/categories':
        return MaterialPageRoute(builder: (ctx) => ListTilezz());
      case '/dashboard':
        return MaterialPageRoute(
            builder: (ctx) => const SmallerTextFactor(DashboardPage()));
      case '/orders':
        return MaterialPageRoute(
            builder: (ctx) => const SmallerTextFactor(OrdersList()));
      case '/profile':
        return MaterialPageRoute(builder: (ctx) => const ProfilePage());
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
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class SmallerTextFactor extends StatelessWidget {
  const SmallerTextFactor(this.child, {Key? key}) : super(key: key);
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
