import 'package:flutter_test/flutter_test.dart';
import 'package:kommando/core/api/api.dart';
import 'package:kommando/features/user/data/models/app_user.dart';
import 'package:kommando/features/user/data/services/user_services.dart';

void main() {
  Api.url = "http://localhost:8080";
  final UserServices userServices = UserServices();

  group("/users", () {
    String uidTest = "";

    test("List users", () async {
      await userServices.fetchUsers().then((value) => print(value));
    });

    test("Deve registrar, validar usuário e deletar", () async {
      AppUser matcher = AppUser(
          displayName: "user test",
          uid: "0123456789",
          cpf: "01212345677",
          nome: "Teste from Dart",
          telefone: "34 3232-9999");

      final value = await userServices.pushUser(user: matcher);

      if (value is AppUser) {
        uidTest = matcher.uid;
        AppUser user = await userServices.fetchUser(uid: uidTest);
        expect(user.uid, matcher.uid);
        await userServices.deleteUserById(id: user.id);
      }
    });
  });
}
