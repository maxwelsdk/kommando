import 'package:flutter/material.dart';
import 'package:kommando/features/lobby/ui/widgets/pedido_desconhecido_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/titulo_secao_widget.dart';
import 'package:kommando/features/lobby/ui/widgets/total_acumulado_widget.dart';

class MyItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meus itens"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TituloSecaoWidget(
              child: Text("Pedidos pendentes"),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: PedidoDesconhecidoWidget(),
            ),
            TituloSecaoWidget(
              child: Text("Total acumulado"),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: TotalAcumuladoWidget(),
            ),
            TituloSecaoWidget(
              child: Text("Pedidos realizados"),
            ),

          ],
        ));
  }
}
