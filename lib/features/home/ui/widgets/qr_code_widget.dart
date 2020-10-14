import 'package:flutter/material.dart';
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
              print("granted");
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
