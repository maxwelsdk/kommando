import 'package:flutter/material.dart';

class UserDataForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _repetirSenhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey;

  UserDataForm({Key key, this.scaffoldKey}) : super(key: key);

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
              key: _formKey,
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
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "E-mail"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Este campo não pode ser vazio";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: _senhaController,
                    decoration: InputDecoration(labelText: "Senha"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Este campo não pode ser vazio";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: _repetirSenhaController,
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
