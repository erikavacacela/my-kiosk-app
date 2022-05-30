import 'package:buy_kiosko/clients/transaction_client.dart';
import 'package:buy_kiosko/pages/payment_data.dart';
import 'package:buy_kiosko/pages/voucher_data.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key, required this.scanBarcode}) : super(key: key);

  final String scanBarcode;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TransactionClient transactionClient = TransactionClient();
  PaymentData paymentData = PaymentData();
  VoucherData voucherData = VoucherData();
  Map _transactionResult = <dynamic, dynamic>{};
  int _indexStep = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _collectSteps = <Widget>[
      stepPaymentData(context),
      stepVoucher(context)
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text.rich(TextSpan(children: [
            WidgetSpan(child: Image.asset('assets/images/wallet-icon-32.png')),
            TextSpan(text: " Monedero Digital "),
          ])),
        ),
        body: _collectSteps[_indexStep]);
  }

  Widget stepPaymentData(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Datos del pago", style: TextStyle(fontSize: 20)),
            paymentData.buildData(widget.scanBarcode),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(
                Icons.send,
                color: Colors.pink,
                size: 24.0,
              ),
              label: Text('Enviar pago'),
              onPressed: () {
                print('Pressed....');
                getVoucher(context);
              },
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
            )
          ],
        ));
  }

  Widget stepVoucher(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Comprobante de pago", style: TextStyle(fontSize: 20)),
            voucherData.buildTable(_transactionResult),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(
                Icons.check_circle,
                color: Colors.pink,
                size: 24.0,
              ),
              label: Text('Aceptar'),
              onPressed: () {
                print('Salir');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
            )
          ],
        ));
  }

  Future<void> getVoucher(BuildContext context) async {
    Map response = await transactionClient.payment(widget.scanBarcode);
    if (response['id'] != null) {
      setState(() {
        _transactionResult = response;
        _indexStep = 1;
      });
    } else if (response['errorMessage'] != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response['errorMessage'])));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ha ocurrido un error al efectuar el pago.')));
    }
  }
}
