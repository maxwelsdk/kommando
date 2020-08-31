import 'package:flutter/material.dart';
import 'package:kommando/signup/screen/widgets/personal_data_widget.dart';
import 'package:kommando/signup/screen/widgets/user_data_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int onPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      PersonalDataForm(
        scaffoldKey: _scaffoldKey,
      ),
      UserDataForm(
        scaffoldKey: _scaffoldKey,
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
                itemCount: widgets.length,
                onPageChanged: (value) {
                  setState(() {
                    onPage = value;
                  });
                },
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    child: widgets[index],
                  );
                }),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      widgets.length,
                      (index) => buildMarker(onPage, index, context),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer buildMarker(int onPage, int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: onPage == index ? 20 : 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: onPage == index ? Theme.of(context).primaryColor : Colors.grey,
      ),
    );
  }
}
