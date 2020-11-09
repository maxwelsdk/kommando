import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/features/signup/ui/screen/widgets/personal_data_widget.dart';
import 'package:kommando/features/signup/ui/screen/widgets/user_data_widget.dart';
import 'package:kommando/features/signup/ui/states/signup_states.dart';
import 'package:kommando/features/signup/ui/stores/signup_store.dart';
import 'package:kommando/features/user/data/models/app_user.dart';

class SignUpScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formPersonKey = GlobalKey<FormState>();

  final _formUserKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();

  final docController = TextEditingController();

  final phoneController = TextEditingController();

  final emailController = TextEditingController();

  final senhaController = TextEditingController();

  final repetirSenhaController = TextEditingController();

  final AppUser _personalData = AppUser();

  final store = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          FocusScope.of(context).unfocus();
          _formPersonKey.currentState.validate();
          _formUserKey.currentState.validate();
          if (_formPersonKey.currentState.validate() &&
              _formUserKey.currentState.validate()) {
            _personalData.nome = nomeController.text;
            _personalData.cpf = docController.text;
            _personalData.telefone = phoneController.text;
            store.createUser(
              email: emailController.text,
              password: senhaController.text,
              user: _personalData,
            );
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              PersonalDataForm(
                formPersonKey: _formPersonKey,
                docController: docController,
                nomeController: nomeController,
                phoneController: phoneController,
              ),
              UserDataForm(
                formUserKey: _formUserKey,
                emailController: emailController,
                senhaController: senhaController,
                repetirSenhaController: repetirSenhaController,
              ),
              Observer(
                builder: (_) {
                  var state = store.state;
                  if (state is SignupSuccesState) {
                    _personalData.uid = state.userCredential.user.uid;
                    Future.delayed(Duration(seconds: 10), () {
                      store.setState(SignupIdleState());
                      Navigator.pop(context);
                    });
                    return Column(
                      children: [
                        Text(
                          "${_personalData.nome} seja bem vindo! Aguarde um instante...",
                        ),
                        Text("Já estou logando você no aplicativo")
                      ],
                    );
                  }
                  if (state is SignupLoadingState) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    );
                  }
                  if (state is SignupErrorState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Text(
                        "${state.message}",
                      )),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
