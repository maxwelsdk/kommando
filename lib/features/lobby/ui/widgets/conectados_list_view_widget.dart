import 'package:flutter/material.dart';

class ConectadosListViewWidget extends StatelessWidget {
  const ConectadosListViewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 16,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 18.0 : 4.0),
            child: CircleAvatar(
              child: Text(index.toString()),
            ),
          );
        },
      ),
    );
  }
}