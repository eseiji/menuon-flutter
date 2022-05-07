// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'login.view.dart';
import 'cadastro.view.dart';
import 'qr_scan.view.dart';

class App extends StatelessWidget {
  // final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: auth.currentUser == null ? LoginPage() : CadastroPage(),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/cadastro': (context) => CadastroPage(),
        '/scan': (context) => QRScanpage(),
      },
    );
  }
}

// auth.currentUser == null ? LoginView() :