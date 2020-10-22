import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kommando/features/home/ui/states/home_states.dart';
import 'package:kommando/features/home/ui/stores/home_store.dart';
import 'package:kommando/features/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class QrCodeWidgetButton extends StatelessWidget {
  const QrCodeWidgetButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeStore = Provider.of<HomeStore>(context);
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
              await _homeStore.findLobbyById(id: result).then((value) {
                var state = _homeStore.state;
                if (state is HomeConnectedState) {
                  Navigator.pushNamed(context, Routes.lobby,
                      arguments: state.lobby.id);
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
