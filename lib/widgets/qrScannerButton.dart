import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/popups/qrErrorPopup.dart';
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
    var result = await BarcodeScanner.scan();

    if (result != null) {
      showSuccessDialog(context, result: result.rawContent);
      parseQrCode(result.rawContent, context);
    }
  } on PlatformException catch (e) {
    var result = ScanResult(
      type: ResultType.Error,
      format: BarcodeFormat.unknown,
    );

    if (e.code == BarcodeScanner.cameraAccessDenied) {
      result.rawContent = 'The user did not grant the camera permission!';
    } else {
      result.rawContent = 'Unknown error: $e';
    }
    showErrorDialog(context, error: result.rawContent);
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
