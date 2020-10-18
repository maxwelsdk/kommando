class AppUser {
  String id;
  String uid;
  String nome;
  String displayName;
  String cpf;
  String telefone;

  AppUser(
      {this.id,
        this.uid,
        this.nome,
        this.displayName,
        this.cpf,
        this.telefone});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    nome = json['nome'];
    displayName = json['displayName'];
    cpf = json['cpf'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['nome'] = this.nome;
    data['displayName'] = this.displayName;
    data['cpf'] = this.cpf;
    data['telefone'] = this.telefone;
    return data;
  }
}
