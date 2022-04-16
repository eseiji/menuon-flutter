import 'package:flutter/material.dart';
import 'package:menuon/model/mensagem.model.dart';

class MensagemItem extends StatelessWidget {
  final MensagemModel model;

  MensagemItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(13, 7, 21, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 55,
            height: 55,
            margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              // backgroundImage: NetworkImage(""),
            ),
          ),
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.nome!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(model.ultimaMensagem!),
                ]),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Text(model.dataUltimaMensagem!.hour.toString()),
              Text(model.dataUltimaMensagem!.hour.toString() +':'+ model.dataUltimaMensagem!.minute.toString()),
              SizedBox(
                height: 4,
              ),
              CircleAvatar(
                child: Text(
                  model.quantidadeNaoLida.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                radius: 11,
                backgroundColor: Color(0xFF1EBE71),
              ),
            ],
          )
        ],
      ),
    );
  }
}
