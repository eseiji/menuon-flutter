import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'mensagem.view.dart';
import 'login.view.dart';
import 'registration.view.dart';
import 'map.view.dart';
import 'qrcode.view.dart';
import 'chat.view.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // print(auth.currentUser!.uid);
    return MaterialApp(
      // home: auth.currentUser == null ? LoginView() : MensagemView(),
      debugShowCheckedModeBanner: false,
      // home: auth.currentUser == null ? LoginView() : ChatView(),
      home: RegistrationView(),
      // home: QRCodeView(),
      // home: MapView(),
      // home: MensagemView(),
      routes: {
        '/mensagens': (context) => MensagemView(),
        '/login': (context) => LoginView(),
        '/chat': (context) => ChatView(),
      },
    );
  }
}

// auth.currentUser == null ? LoginView() :