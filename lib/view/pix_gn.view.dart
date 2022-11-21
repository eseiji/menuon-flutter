import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gerencianet/gerencianet.dart';

import '../optons.dart';

class PixChargeView extends StatefulWidget {
  const PixChargeView({Key? key}) : super(key: key);

  @override
  State<PixChargeView> createState() => _PixChargeViewState();
}

class _PixChargeViewState extends State<PixChargeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [TextFormField(decoration: InputDecoration())],
      ),
    );
  }

  void _createCharge() {
    Gerencianet gn = Gerencianet(OPTIONS);

    Map<String, dynamic> body = {
      "calendario": {
        "expiracao": int.parse("2022-12-18"),
      },
      "valor": {
        "original": int.parse("10000"),
      },
      "chave": "isadj9a8sjd9sa",
    };

    gn.call("pixCreateImmediateCharge", body: body).then((value) {
      gn.call("pixGenerateQRCode", params: {"id": value['loc']['id']}).then(
          (value) {
        setState(() {});
      });
    }).catchError((onError) => print(onError));
  }
}
