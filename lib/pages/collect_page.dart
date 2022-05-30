import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:buy_kiosko/utils/globals.dart' as globals;
import 'dart:convert';

class CollectPage extends StatefulWidget {
  CollectPage() : super();

  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  final _formKey = GlobalKey<FormState>();
  int _indexStep = 0;
  String data = "";
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> _collectSteps = <Widget>[
      stepRequestAmount(context),
      stepShowQR(context)
    ];
    return _collectSteps[_indexStep];
  }

  Widget stepRequestAmount(context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Cobrar", style: TextStyle(fontSize: 25)),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(30),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monto',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: amountController,
                        inputFormatters: [DecimalTextInputFormatter()],
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el monto';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Descripción',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la descripción';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                createDataForQR();
                                _indexStep = 1;
                                print('Selected index: ${_indexStep}');
                              });
                            }
                          },
                          child: const Text('Generar código QR'),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ));
  }

  void createDataForQR() {
    Map mapData = {
      'receiverAccountId': globals.currentUser['accountId'],
      'receiverName':
          '${globals.currentUser['firstName']} ${globals.currentUser['lastName']}',
      'amount': amountController.text,
      'description': descriptionController.text
    };
    this.data = json.encode(mapData);
  }

  Widget stepShowQR(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Codigo QR", style: TextStyle(fontSize: 25)),
            SizedBox(height: 30),
            QrImage(
              data: this.data,
              version: QrVersions.auto,
              size: 225.0,
            )
          ],
        ));
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r'^\d*\.?\d*');
    final String newString = regEx.stringMatch(newValue.text) ?? '';
    return newString == newValue.text ? newValue : oldValue;
  }
}
