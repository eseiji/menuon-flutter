import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:io' show Platform;

class QRScanpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanpage> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  void redirect(BuildContext context, String? link) async {
    controller!.dispose();
    // controller!.pauseCamera();
    // Navigator.of(context).pushNamed('/menu', arguments: {'company': link});
    // Navigator.of(context)
    //     .popAndPushNamed('/menu', arguments: {'company': link});

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('company', link!);

    Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false,
        arguments: {'company': link});

    // Navigator.of(context).
  }

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }

    controller!.resumeCamera();
    // controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: const Color(0xFF5767FE),
        //   title: Container(
        //     child: Row(
        //       children: const [
        //         Icon(FontAwesomeIcons.wineGlassAlt),
        //         SizedBox(width: 5.0),
        //         Text(
        //           'MENU ON',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.more_vert),
        //       tooltip: 'Options',
        //       onPressed: () {},
        //     ),
        //   ],
        // ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
          ],
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Color(0xFF5767FE),
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.6,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      reassemble();
    });

    controller.scannedDataStream.listen(
      (barcode) => setState(
        () {
          this.barcode = barcode;
          redirect(context, barcode.code);
        },
      ),
    );
  }

  @override
  void didPopNext() {
    setState(() {
      //force widget to re-create when user navigate back
    });
  }
}
