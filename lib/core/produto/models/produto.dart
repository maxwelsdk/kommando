class Produto {
  String id;
  int codigo;
  String descricao;
  double preco;

  Produto({this.id, this.codigo, this.descricao, this.preco});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigo = json['codigo'];
    descricao = json['descricao'];
    preco = json['preco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codigo'] = this.codigo;
    data['descricao'] = this.descricao;
    data['preco'] = this.preco;
    return data;
  }
}
