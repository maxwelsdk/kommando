import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kommando/features/item/ui/stores/my_item_store.dart';

class ControleQuantidadeWidget extends StatelessWidget {
  final MyItemStore myItemStore;

  const ControleQuantidadeWidget({
    Key key,
    this.myItemStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Material(
          child: InkWell(
            onTap: () {
              myItemStore.minusQuantidade();
            },
            child: SvgPicture.asset(
              'assets/minus.svg',
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.15,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: Observer(
              builder: (context) => Text(
                myItemStore.item.quantidade.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Material(
          child: InkWell(
            onTap: () {
              myItemStore.plusQuantidade();
            },
            child: SvgPicture.asset(
              'assets/plus.svg',
            ),
          ),
        ),
      ],
    );
  }
}
