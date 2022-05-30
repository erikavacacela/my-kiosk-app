import 'package:buy_kiosko/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQRPage extends StatefulWidget {
  ScanQRPage() : super();

  @override
  _ScanQRPagePageState createState() => _ScanQRPagePageState();
}

class _ScanQRPagePageState extends State<ScanQRPage> {
  Future<void> scanQR(context) async {
    String barcodeScanRes = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      print('Failed to get platform version.');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (barcodeScanRes != '-1') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PaymentPage(scanBarcode: barcodeScanRes)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text("Escanea el código QR", style: TextStyle(fontSize: 25)),
            Text(""),
            Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () => scanQR(context),
                        child:
                            Text('Escanear QR', style: TextStyle(fontSize: 20)))
                  ]),
            )
          ],
        ));
  }
}
