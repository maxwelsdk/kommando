class Categoria {
  String id;
  String nome;
  List<String> itens;

  Categoria({this.id, this.nome, this.itens});

  Categoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    if (json['itens'] != null) {
      itens = List<String>();
      json['itens'].forEach((v) {
        itens.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    if (this.itens != null) {
      data['itens'] = this.itens.map((e) => e).toList();
    }
    return data;
  }
}
