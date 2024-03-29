import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_on/view/components/teste.dart';
import 'package:menu_on/view/order.view.dart';
import 'package:menu_on/view/order_history.view.dart';
import 'package:menu_on/view/order_history_details.view.dart';
import 'package:menu_on/view/payment.view.dart';
import './view/login.view.dart';
import './view/qr_scan.view.dart';
import './view/register.view.dart';
import './view/menu.view.dart';
// import 'globals.dart';
import 'package:menu_on/globals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      title: 'Menu ON',
      scaffoldMessengerKey: snackbarKey,
      // theme: GoogleFonts.harmattan(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ),
        // textTheme: GoogleFonts.cantarellTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      home: LoginPage(),
      // home: auth.currentUser == null ? LoginPage() : MenuPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/scan': (context) => const Scanner(),
        // '/scan': (context) => QRScanpage(),
        '/menu': (context) => const MenuPage(),
        '/cart': (context) => CartScreen(),
        // '/product_details': (context) => DetailsScreen2(),
        '/teste2': (context) => const Teste(),
        '/payment': (context) => PaymentView(),
        '/order_history': (context) => const OrderHistoryView(),
        '/order_history_details': (context) => OrderHistoryDetailsView(),
      },
    );
  }
}

/** 
* appBar na tela de detalhes do produto (menu) - FEITO
* refresh na tela de pagamentos (histórico) - FEITO
* badge do carrinho - FEITO
* data do pagamento do pix - FEITO
* botões do awesome dialog
 */
