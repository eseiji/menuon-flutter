// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'login.view.dart';
import 'registration.view.dart';
import 'qr_scan.view.dart';

class App extends StatelessWidget {
  // final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // print(auth.currentUser!.uid);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: auth.currentUser == null ? LoginView() : ChatView(),
      home: QRScanpage(),
      routes: {
        // '/mensagens': (context) => MensagemView(),
        '/login': (context) => LoginView(),
        '/qrcode': (context) => QRScanpage(),
        // '/chat': (context) => ChatView(),
      },
    );
  }
}

// auth.currentUser == null ? LoginView() :