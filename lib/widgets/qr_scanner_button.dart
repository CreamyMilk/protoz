import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/popups/qr_error_popup.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeScannerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          initateScan(context);
        },
        icon: Icon(
          Icons.qr_code_outlined,
          color: Colors.black26,
          size: 19,
        ));
  }
}

void initateScan(BuildContext context) async {
  try {
    var result = await FlutterBarcodeScanner.scanBarcode(
        "0xffffff", "exit", false, ScanMode.QR);
  } on PlatformException catch (e) {
    showErrorDialog(context, error: "");
  }
}

void parseQrCode(String qrData, BuildContext ctx) async {
  var box = Hive.box(Constants.UserBoxName);
  if (qrData.startsWith("SM")) {
    List<String> values = qrData.split("|");
    box.put(Constants.ReceiverNumberStore, values[1]);
    if (values.length == 3) {
      box.put(Constants.AmountToSendStore, values[2]);
    }
    Navigator.of(ctx).pushNamed("/enteramount");
  }
  if (qrData.startsWith("http")) {
    //If the scanned code is a url
    if (await canLaunch(qrData)) {
      launch(qrData);
    }
  }
}
