class Produto {
  String id;
  int codigo;
  String titulo;
  String descricao;
  double preco;

  Produto({this.id, this.codigo,this.titulo, this.descricao, this.preco});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codigo = json['codigo'];
    titulo = json['titulo'];
    descricao = json['descricao'];
    preco = json['preco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codigo'] = this.codigo;
    data['titulo'] = this.titulo;
    data['descricao'] = this.descricao;
    data['preco'] = this.preco;
    return data;
  }
}
