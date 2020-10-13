import 'package:flutter/material.dart';

class UserDataForm extends StatelessWidget {
  final emailController;

  final senhaController;

  final repetirSenhaController;

  final GlobalKey<FormState> formUserKey;

  final List<FocusNode> nodes = List();

  UserDataForm(
      {Key key,
      this.formUserKey,
      this.emailController,
      this.senhaController,
      this.repetirSenhaController})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    List.generate(3, (index) => nodes.add(FocusNode()));

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text("usuário"),
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
                    focusNode: nodes[0],
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(nodes[1]),
                    decoration: InputDecoration(labelText: "e-mail"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != repetirSenhaController.text)
                        return "Senha incompativel";
                      if (value.isEmpty) {
                        return "Este campo não pode ser vazio";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: senhaController,
                    obscureText: true,
                    focusNode: nodes[1],
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(nodes[2]),
                    decoration: InputDecoration(labelText: "senha"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != senhaController.text)
                        return "Senha incompativel";
                      if (value.isEmpty) {
                        return "Este campo não pode ser vazio";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: repetirSenhaController,
                    obscureText: true,
                    focusNode: nodes[2],
                    decoration: InputDecoration(labelText: "repetir senha"),
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
