class ProductModel {
  int idProduct = 0;
  String? imagemUrl = '';
  String nome = '';
  String descricao = '';
  String preco = '';
  dynamic tamanho;

  ProductModel(this.idProduct, this.nome, this.descricao, this.preco);

  ProductModel.fromMap(Map<String, dynamic> map) {
    // imagemUrl = 'https://ibb.co/njkYvVJ';
    // imagemUrl = map['imagemUrl'] != null ? map['imagemUrl'] : null;
    idProduct = map['id_product'];
    nome = map['name'];
    descricao = map['description'];
    preco = map['price'];
    // tamanho = map['tamanho'];

    // quantidadeNaoLida = map['quantidadeNaoLida'] ?? 'valor'; TBM PODE SER USADO ASSIM
  }
}
