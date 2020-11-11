class Lobby {
  String id;
  String descricao;
  String lobbyStatus;
  List<String> consumidores;

  Lobby({this.id, this.descricao, this.lobbyStatus, this.consumidores});

  Lobby.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    lobbyStatus = json['lobbyStatus'];
    if (json['consumidores'] != null) {
      consumidores = new List<String>();
      json['consumidores'].forEach((v) {
        consumidores.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['lobbyStatus'] = this.lobbyStatus;
    if (this.consumidores != null) {
      data['consumidores'] = this.consumidores.map((v) => v).toList();
    }
    return data;
  }
}
