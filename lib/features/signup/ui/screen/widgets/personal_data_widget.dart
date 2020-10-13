import 'package:flutter/material.dart';

class PersonalDataForm extends StatelessWidget {
  final nomeController;

  final docController;

  final phoneController;

  final GlobalKey<FormState> formPersonKey;

  final List<FocusNode> nodes = List();

  PersonalDataForm(
      {Key key,
      this.formPersonKey,
      this.nomeController,
      this.docController,
      this.phoneController})
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
                  Text("dados pessoais"),
                  Divider(),
                ],
              ),
            ),
            Form(
              key: formPersonKey,
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
                    controller: nomeController,
                    focusNode: nodes[0],
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(nodes[1]),
                    decoration: InputDecoration(labelText: "nome completo"),
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
                    keyboardType: TextInputType.number,
                    controller: docController,
                    focusNode: nodes[1],
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(nodes[2]),
                    decoration: InputDecoration(labelText: "cpf"),
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
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    focusNode: nodes[2],
                    decoration: InputDecoration(labelText: "telefone"),
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
