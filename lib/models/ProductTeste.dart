class ProductModel {
  String? imagemUrl;
  String nome = '';
  String descricao = '';
  int preco = 0;
  int tamanho = 0;

  ProductModel(this.imagemUrl, this.nome, this.descricao, this.preco, this.tamanho);

  ProductModel.fromMap(String nomeA, Map<String, dynamic> map) {
    imagemUrl = map['imagemUrl'];
    nome = nomeA;
    descricao = map['descricao'];
    preco = map['preco'];
    tamanho = map['tamanho'];

    // quantidadeNaoLida = map['quantidadeNaoLida'] ?? 'valor'; TBM PODE SER USADO ASSIM
  }
}
