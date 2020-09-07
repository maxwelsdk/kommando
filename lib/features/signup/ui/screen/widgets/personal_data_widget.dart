import 'package:flutter/material.dart';

class PersonalDataForm extends StatelessWidget {
  final nomeController;

  final docController;

  final phoneController;

  final GlobalKey<FormState> formPersonKey;

  PersonalDataForm(
      {Key key,
      this.formPersonKey,
      this.nomeController,
      this.docController,
      this.phoneController})
      : super(key: key);

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
                  Text("Dados pessoais"),
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
                    decoration: InputDecoration(labelText: "Nome completo"),
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
                    decoration: InputDecoration(labelText: "CPF"),
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
                    decoration: InputDecoration(labelText: "Telefone"),
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
