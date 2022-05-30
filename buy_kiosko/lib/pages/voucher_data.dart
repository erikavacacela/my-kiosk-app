import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoucherData {
  const VoucherData();

  DataTable buildTable(Map voucherData) {
    String transactionId = 'S/D', receiver = 'S/D', amount = 'S/D';
    String description = 'S/D', formattedDate = 'S/D', formattedTime = 'S/D';
    if (voucherData.isNotEmpty) {
      transactionId = 'ABC${voucherData['id']}';
      receiver =
          '${voucherData['receiverFirstName']} ${voucherData['receiverLastName']}';
      var parsedDate = DateTime.parse(voucherData['date']);
      formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      formattedTime = DateFormat('hh:mm:ss').format(parsedDate);
      amount = '\$ ${voucherData['amount']}';
      description = voucherData['description'];
    }

    return DataTable(
      columns: const <DataColumn>[
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
              'Comprobante',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            DataCell(Text(transactionId)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Referencia',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            DataCell(Text(receiver)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Fecha',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            DataCell(Text(formattedDate)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text(
              'Hora de pago',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            DataCell(Text(formattedTime)),
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
            DataCell(Text(description)),
          ],
        ),
      ],
    );
  }
}
