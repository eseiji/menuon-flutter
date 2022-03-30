class MensagemModel {
  String? imagemUrl;
  String? nome;
  String? ultimaMensagem;
  DateTime? dataUltimaMensagem;
  int? quantidadeNaoLida;

  MensagemModel(
      this.imagemUrl, this.nome, this.ultimaMensagem, this.dataUltimaMensagem,
      {this.quantidadeNaoLida = 0});

  MensagemModel.fromMap(Map<String, dynamic> map) {
    imagemUrl = map['imagemUrl'];
    nome = map['nome'];
    ultimaMensagem = map['ultimaMensagem'];
    dataUltimaMensagem = map['dataUltimaMensagem'].toDate();
    quantidadeNaoLida = map['quantidadeNaoLida'];

    // quantidadeNaoLida = map['quantidadeNaoLida'] ?? 'valor'; TBM PODE SER USADO ASSIM
  }
}
