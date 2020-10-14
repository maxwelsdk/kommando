import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kommando/core/ui/linear_background_widget.dart';
import 'package:kommando/features/drawer/ui/widgets/drawer_widget.dart';
import 'package:kommando/features/home/ui/widgets/qr_code_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            LinearBackgroundWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        "Conectar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                  ),
                  child: QrCodeWidgetButton(),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Recentes"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("PUNCH SMASH BURGER"),
                              Text("R\$ 54,50"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}