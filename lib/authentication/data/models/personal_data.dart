class PersonalData {
  String nome;
  String cpf;
  String telefone;
  String uid;

  PersonalData({this.nome, this.cpf, this.telefone, this.uid});

   PersonalData.fromMap(Map<String, dynamic> map) {
     this.nome = map['nome'];
     this.cpf = map['cpf'];
     this.telefone = map['telefone'];
     this.uid = map['uid'];
  }

  Map<String, dynamic> toMap() {
     final map = Map<String, dynamic>();
     map['nome'] = this.nome;
     map['cpf'] = this.cpf;
     map['telefone'] = this.telefone;
     map['uid'] = this.uid;
     return map;
  }

  @override
  String toString() {
    return 'PersonalData{nome: $nome, cpf: $cpf, telefone: $telefone, uid: $uid}';
  }
}