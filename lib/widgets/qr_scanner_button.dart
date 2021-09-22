import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proto/constants.dart';
import 'package:proto/utils/sizedMargins.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';

class QrCodeScannerIcon extends StatelessWidget {
  const QrCodeScannerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/qrscanner");
        },
        icon: const Icon(
          Icons.qr_code_outlined,
          color: Colors.black26,
          size: 19,
        ));
  }
}

void parseQrCode(Barcode? qrData, BuildContext ctx) async {
  var box = Hive.box(Constants.UserBoxName);
  if (qrData != null && qrData.code.startsWith("SM")) {
    List<String> values = qrData.code.split("|");
    if (values.length == 3) {
      box.put(Constants.AmountToSendStore, values[2]);
    }
    Navigator.of(ctx).pop();
    Navigator.of(ctx).pushNamed("/enteramount");
  }
  if (qrData != null && qrData.code.startsWith("http")) {
    //If the scanned code is a url
    if (await canLaunch(qrData.code)) {
      launch(qrData.code);
    }
  }
}

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text('Scanned Data: ${result!.code}')
                  else
                    const Text(''),
                  MaterialButton(
                    elevation: 0,
                    height: 60,
                    minWidth: screenWidth(context, percent: .90),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    color: Colors.green,
                    child: const Text(
                      "Close",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    autofocus: false,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      parseQrCode(scanData, context);
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
