import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class QrCodeWidgetButton extends StatelessWidget {
  const QrCodeWidgetButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          Permission.camera.request().then((value) {
            if (value.isDenied || value.isPermanentlyDenied) openAppSettings();
            if (value.isGranted) {
              FlutterBarcodeScanner.scanBarcode(
                      "#ff6666", "Cancelar", true, ScanMode.QR)
                  .then((value) => Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(value))))
                  .catchError((onError) => print("Error: $onError"));
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
