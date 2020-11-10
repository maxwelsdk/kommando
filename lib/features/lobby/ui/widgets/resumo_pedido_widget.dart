import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kommando/features/item/ui/screen/my_item_screen.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';
import 'package:kommando/utils/money_utils.dart';
import 'package:provider/provider.dart';

class ResumoPedidoWidget extends StatelessWidget {
  const ResumoPedidoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyItemStore _myItemStore = Provider.of<MyItemStore>(context);

    return Container(
      height: 80,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              SvgPicture.asset(
                "assets/file.svg",
                color: Colors.white,
                height: 35,
              ),
              Positioned(
                bottom: -3,
                right: -1,
                child: Container(
                  height: 16,
                  width: 16,
                  child: Center(
                    child: Observer(
                      builder: (context) => Text(
                        "${_myItemStore.itens.length ?? 0}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyItemScreen(),
                  ));
            },
            child: Text(
              "Ver itens",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Observer(
              builder: (context) => Text(
                    "R\$${MoneyUtils.parseDoubleToMoneyText(_myItemStore.getTotalAcumuladoPedido())}",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ))
        ],
      ),
    );
  }
}
