import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ControleQuantidadeWidget extends StatelessWidget {
  const ControleQuantidadeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Material(
          child: InkWell(
            onTap: () {
              print("minus");
            },
            child: SvgPicture.asset(
              'assets/minus.svg',
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: Text(
              "1",
              textAlign: TextAlign.center,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
        ),
        Material(
          child: InkWell(
            onTap: () {
              print("plus");
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