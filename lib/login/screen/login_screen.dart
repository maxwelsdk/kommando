import 'package:flutter/material.dart';
import 'package:kommando/login/screen/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

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
                height: MediaQuery.of(context).size.height * 0.6,
                color: Colors.white,
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 60,
                          ),
                        ),
                        TextFormField(
                          controller: _emailAddressController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "E-maill",
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Senha"),
                        ),
                        CustomButton(
                          text: "Entrar",
                          onPressed: () {},
                        ),
                        CustomButton(
                          text: "Registrar",
                          onPressed: () {},
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
