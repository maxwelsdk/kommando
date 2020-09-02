import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kommando/authentication/data/models/personal_data.dart';
import 'package:kommando/authentication/screen/widgets/custom_button.dart';
import 'package:kommando/signup/screen/widgets/personal_data_widget.dart';
import 'package:kommando/signup/screen/widgets/user_data_widget.dart';
import 'package:kommando/signup/states/signup_states.dart';
import 'package:kommando/signup/stores/signup_store.dart';
import 'package:provider/provider.dart';

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

  final PersonalData _personalData = PersonalData();

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<SignupStore>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: SingleChildScrollView(
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
                  return Icon(
                    Icons.check_circle,
                    size: 60,
                    color: Colors.green,
                  );
                }
                return CustomButton(
                  text: "salvar",
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formPersonKey.currentState.validate() &&
                        _formUserKey.currentState.validate()) {
                      _personalData.nome = nomeController.text;
                      _personalData.cpf = docController.text;
                      _personalData.telefone = phoneController.text;
                      store.createUser(
                          email: emailController.text,
                          password: senhaController.text);
                    }
                  },
                );
              },
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
                  return Text(
                      "${_personalData.nome} vou te redirecionar para home.");
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
                      "${state.firebaseAuthException.message}",
                    )),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
