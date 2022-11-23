import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:gerencianet/gerencianet.dart';
import 'package:menu_on/options.dart';

class CreateChargeView extends StatefulWidget {
  const CreateChargeView({Key? key}) : super(key: key);

  @override
  State<CreateChargeView> createState() => _CreateChargeViewState();
}

class _CreateChargeViewState extends State<CreateChargeView> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  TextEditingController _valueController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crair transação")),
      floatingActionButton: FloatingActionButton(
        onPressed: _createCharge,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nome do produto'),
          ),
          TextFormField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Quantidade'),
          ),
          TextFormField(
            controller: _valueController,
            decoration: InputDecoration(labelText: 'Valor do produto'),
          )
        ],
      ),
    );
  }

  void _createCharge() {
    Gerencianet gn = Gerencianet(OPTIONS);

    Map<String, dynamic> body = {
      "items": [
        {
          "name": _nameController.text,
          "amount": _nameController.text,
          "value": _nameController.text,
        }
      ]
    };

    gn
        .call("createCharge", body: body)
        .then((value) => print(value))
        .catchError((err) => print(err));
  }

  // Widget _drawer() {
  //   return Drawer(
  //     child: ListView(
  //       children: [
  //         ListTile(
  //           title: Text("Create transaction"),
  //         )
  //       ],
  //     ),
  //   )
  // }
}
