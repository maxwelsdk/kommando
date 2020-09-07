import 'package:flutter/material.dart';

class UserDataForm extends StatelessWidget {

  final emailController;

  final senhaController;

  final repetirSenhaController;

  final GlobalKey<FormState> formUserKey;

  UserDataForm({Key key, this.formUserKey, this.emailController, this.senhaController, this.repetirSenhaController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text("Usuário"),
                  Divider(),
                ],
              ),
            ),
            Form(
              key: formUserKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Este campo não pode ser vazio";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(labelText: "E-mail"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != repetirSenhaController.text) return "Senha incompativel";
                      if (value.isEmpty) {
                        return "Este campo não pode ser vazio";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: senhaController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Senha"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != senhaController.text) return "Senha incompativel";
                      if (value.isEmpty) {
                        return "Este campo não pode ser vazio";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: repetirSenhaController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Repetir senha"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
