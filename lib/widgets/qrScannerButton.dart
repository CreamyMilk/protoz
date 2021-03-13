import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto/widgets/popups/qrErrorPopup.dart';

class QrCodeScannerIcon extends StatelessWidget{
  void scan(BuildContext context) async {
 
    try {
      var result = await BarcodeScanner.scan();
    
      if (result != null) {
        showSuccessDialog(context,result:result.rawContent);
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
  @override
  Widget build(BuildContext context) {
    return         IconButton(
            onPressed:(){scan(context);},
            icon: Icon(
              Icons.qr_code_outlined,
              color: Colors.black26,
              size: 19,
            ));
  }
}

