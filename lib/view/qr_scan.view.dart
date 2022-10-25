import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_on/services/companies.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:convert' as convert;

import 'dart:io' show Platform;

class QRScanpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanpage> {
  final _companies = Companies();
  String status = 'reading';
  void messageAlert(String message) {
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void redirect(BuildContext context, String? link) async {
    Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
  }

  void checkCompany(String idCompany) async {
    // setState(() {
    //   status = 'loading';
    // });
    status = 'loading';
    final response = await _companies.getCompany(idCompany);
    if (response['id_company'] != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('company', convert.jsonEncode(response));
      messageAlert('Login realizado com sucesso.');
      // await cameraController.stop();
      Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false);
    } else {
      // setState(() {
      //   status = 'reading';
      // });
      status = 'reading';
      messageAlert('E-mail ou senha inválidos.');
    }
  }

  // Barcode? barcode;
  // QRViewController? controller;

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  // @override
  // void reassemble() async {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     await controller!.pauseCamera();
  //   }

  //   controller!.resumeCamera();
  //   // controller!.resumeCamera();
  // }

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

  MobileScannerController cameraController = MobileScannerController();
  Widget buildQrView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escaneie o QRCode'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff181920),
        ),
        child: Center(
          child: Container(
              margin: const EdgeInsets.all(10.0),
              // color: Colors.amber[600],
              width: 300.0,
              height: 300.0,
              child: status == 'reading'
                  ? MobileScanner(
                      allowDuplicates: true,
                      controller: cameraController,
                      onDetect: (barcode, args) {
                        if (barcode.rawValue == null) {
                          debugPrint('Failed to scan Barcode');
                        } else {
                          final String code = barcode.rawValue!;
                          checkCompany(code);
                          debugPrint('Barcode found! $code');
                        }
                      },
                    )
                  : null),
        ),
      ),
    );
    // QRView(
    //   key: qrKey,
    //   onQRViewCreated: onQRViewCreated,
    //   overlay: QrScannerOverlayShape(
    //     borderColor: Color(0xFF5767FE),
    //     borderRadius: 10,
    //     borderLength: 20,
    //     borderWidth: 10,
    //     cutOutSize: MediaQuery.of(context).size.width * 0.6,
    //   ),
    // );
  }

  // void onQRViewCreated(QRViewController controller) {
  //   setState(() {
  //     this.controller = controller;
  //     reassemble();
  //   });

  //   controller.scannedDataStream.listen(
  //     (barcode) => setState(
  //       () {
  //         this.barcode = barcode;
  //         redirect(context, barcode.code);
  //       },
  //     ),
  //   );
  // }

  // @override
  // void didPopNext() {
  //   setState(() {
  //     //force widget to re-create when user navigate back
  //   });
  // }
}
