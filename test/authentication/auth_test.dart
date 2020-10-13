
import 'package:flutter_test/flutter_test.dart';
import 'package:kommando/core/api/api.dart';
import 'package:kommando/features/authentication/data/models/personal_data.dart';
import 'package:kommando/features/user/data/services/user_services.dart';

void main() {
  Api.url = "http://localhost:8080";
  final UserServices userServices = UserServices();

  test("List users", () async {
    await userServices.fetchUsers().then((value) {
      for(User i in value) {
        print(i.toJson());
      }
    });
  });

  test("Registro de usuário autenticado", () async {

    await userServices
        .pushUser(
            user: User(
                displayName: "teste",
                uid: "fakeuid 2",
                cpf: "95",
                nome: "teste",
                telefone: "21321321"))
        .then((value) => print(value));
  });
}
