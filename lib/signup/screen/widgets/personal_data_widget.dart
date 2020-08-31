import 'package:flutter/material.dart';

class PersonalDataForm extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _docController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey;

  PersonalDataForm({Key key, this.scaffoldKey}) : super(key: key);

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
                    controller: _nomeController,
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
                    controller: _docController,
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
                    controller: _phoneController,
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
