import 'package:flutter/material.dart';
import 'dart:convert';

class PaymentData {
  const PaymentData();

  DataTable buildData(String stringData) {
    String receiverName = 'S/D';
    String amount = 'S/D';
    String descripcion = 'S/D';
    if (stringData.isNotEmpty) {
      Map data = json.decode(stringData);
      receiverName = data['receiverName'];
      amount = '\$ ${data['amount']}';
      descripcion = data['description'];
    }

    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            '',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            '',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        )
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Recibe',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            DataCell(Text(receiverName)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Monto',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            DataCell(Text(amount)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Descripción',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            DataCell(Text(descripcion)),
          ],
        ),
      ],
    );
  }
}
