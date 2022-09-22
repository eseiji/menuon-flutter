class ProductModel {
  String? imagemUrl = '';
  String nome = '';
  String descricao = '';
  String preco = '';
  dynamic tamanho;

  ProductModel(this.nome, this.descricao, this.preco);

  ProductModel.fromMap(String nomeA, Map<String, dynamic> map) {
    // imagemUrl = 'https://ibb.co/njkYvVJ';
    // imagemUrl = map['imagemUrl'] != null ? map['imagemUrl'] : null;
    nome = map['name'];
    descricao = map['description'];
    preco = map['price'];
    // tamanho = map['tamanho'];

    // quantidadeNaoLida = map['quantidadeNaoLida'] ?? 'valor'; TBM PODE SER USADO ASSIM
  }
}
