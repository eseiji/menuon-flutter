import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanpage> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  void redirect(BuildContext context, String? link) {
    print(context);
    print(link);
    Navigator.of(context).pushNamed('/${link}');
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

//     if (Platform.isAndroid) {
//     await controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQrView(context),
              Positioned(bottom: 10, child: buildResult()),
            ],
          ),
        ),
      );

  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.purpleAccent,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.purple,
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          onPressed: () =>
              {if (barcode != null) redirect(context, barcode!.code)},
          child: Text("Escanear"),
        ),
// child: Text(

//     barcode != null ? 'Resultado : ${barcode!.code}' : 'Escaneie o QRCode',
//     maxLines: 3,
//     style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
// ),
      );
  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.purpleAccent,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.6,
        ),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }
}
