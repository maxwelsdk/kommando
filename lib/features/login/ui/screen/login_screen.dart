import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/core/ui/linear_background_widget.dart';
import 'package:kommando/core/ui/projeto_kommando_logo_widget.dart';
import 'package:kommando/features/login/ui/screen/widgets/custom_button.dart';
import 'package:kommando/features/login/ui/states/login_state.dart';
import 'package:kommando/features/login/ui/stores/login_store.dart';
import 'package:kommando/features/signup/ui/screen/signup_screen.dart';
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          LinearBackgroundWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Container(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.50
                          : MediaQuery.of(context).size.height * 0.70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Form(
                        key: _key,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ProjetoKommandoLogoWidget(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: TextFormField(
                                  controller: _emailAddressController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "E-maill",
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Informe o e-mail por favor";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: TextFormField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Senha",
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "É necessário informar a senha";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              CustomButton(
                                text: "entrar",
                                onPressed: () {
                                  if (_key.currentState.validate()) {
                                    FocusScope.of(context).unfocus();
                                    store.loginWithEmailAndPassword(
                                        email: _emailAddressController.text,
                                        password: _passwordController.text);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: Text(
                        "registrar-se",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SignUpScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Observer(
                      builder: (BuildContext context) {
                        var state = store.state;
                        if (state is LoginLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            ),
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
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
