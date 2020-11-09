import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kommando/core/consumidor/data/models/consumidor.dart';
import 'package:kommando/features/consumidor/ui/states/consumidor_states.dart';
import 'package:kommando/features/consumidor/ui/stores/consumidor_store.dart';
import 'package:kommando/features/lobby/ui/states/lobby_states.dart';
import 'package:kommando/features/lobby/ui/stores/lobby_store.dart';
import 'package:kommando/features/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class QrCodeWidgetButton extends StatelessWidget {
  const QrCodeWidgetButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _lobbyStore = Provider.of<LobbyStore>(context);
    final _consumidorStore = Provider.of<ConsumidorStore>(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          Permission.camera.request().then((value) async {
            if (value.isDenied || value.isPermanentlyDenied) openAppSettings();
            if (value.isGranted) {
              final result = await FlutterBarcodeScanner.scanBarcode(
                      "#ff6666", "Cancelar", true, ScanMode.QR)
                  .catchError((onError) => print("Error: $onError"));
              await _lobbyStore.findLobbyById(id: result).then((value) {
                var state = _lobbyStore.state;
                if (state is LobbyConnectedState) {
                  var consumidorState = _consumidorStore.state;

                  _consumidorStore.pushConsumidor(
                      consumidor: Consumidor(
                    lobbyId: state.lobby.id,
                    uid: FirebaseAuth.instance.currentUser.uid,
                  ));

                  if (consumidorState is ConsumidorCreatedState) {
                    Navigator.pushNamed(context, Routes.lobby,
                        arguments: state.lobby.id);
                  }
                }
              });
            }
          });
        },
        child: SvgPicture.asset(
          "assets/qr_code.svg",
          color: Colors.white,
          height: 150,
        ),
      ),
    );
  }
}
