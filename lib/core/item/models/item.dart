class Item {
  String id;
  String produtoId;
  int quantidade;

  Item({this.id, this.produtoId, this.quantidade});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    produtoId = json['produtoId'];
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['produtoId'] = this.produtoId;
    data['quantidade'] = this.quantidade;
    return data;
  }
}
