import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/authentication/screen/widgets/custom_button.dart';
import 'package:kommando/authentication/states/login_state.dart';
import 'package:kommando/authentication/stores/login_store.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LoginStore>(context);

    return Scaffold(
      key: _scaffoldKey,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  color: Colors.white,
                  child: Form(
                    key: _key,
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo não pode ficar vazio";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Senha",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo não pode ficar vazio";
                              }
                              return null;
                            },
                          ),
                          CustomButton(
                            text: "Entrar",
                            onPressed: () {
                              if (_key.currentState.validate()) {
                                store.loginWithEmailAndPassword(
                                    email: _emailAddressController.text,
                                    password: _passwordController.text);
                              }
                            },
                          ),
                          Container(
                            child: FlatButton(
                              child: Text("Registrar-se"),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Observer(
                builder: (BuildContext context) {
                  var state = store.state;
                  if (state is LoginLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is LoginErrorState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Text(
                        "${state.firebaseAuthException.message}",
                      )),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
