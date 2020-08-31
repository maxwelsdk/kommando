import 'package:flutter/material.dart';
import 'package:kommando/authentication/data/services/authentication_services.dart';

class LoginScreen extends StatelessWidget {

  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _service = AuthenticationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
              stops: [0, 1],
            ),
          ),
          child: Center(
            child: Card(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.white,
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 60,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _emailAddressController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "E-maill",
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Senha"),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          color: Colors.red,
                          width: 200,
                          child: FlatButton(
                            child: Text("Entrar"),
                            onPressed: () {
                              _service.loginWithEmailAndPassword(_emailAddressController.text, _passwordController.text);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
