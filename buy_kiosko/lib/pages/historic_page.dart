import 'package:flutter/material.dart';
import 'package:buy_kiosko/utils/globals.dart' as globals;

class HistoricalPage extends StatefulWidget {
  HistoricalPage({required this.historicList}) : super();

  final List<dynamic> historicList;

  @override
  _HistoricalPageState createState() => _HistoricalPageState();
}

class _HistoricalPageState extends State<HistoricalPage> {
  var _selectedList = [];

  void _toggle(int index) {
    setState(() {
      _selectedList[index] = !_selectedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedList =
        List<bool>.generate(widget.historicList.length, (_) => true);
    if (_selectedList.length == 0) {
      return ListView.builder(
          itemCount: 1,
          itemBuilder: (_, int index) {
            return ListTile(
                leading: Icon(Icons.info_rounded),
                title: Text('No hay registros.'),
                subtitle: Text(''));
            ;
          });
    }
    return ListView.builder(
        itemCount: widget.historicList.length,
        itemBuilder: (_, int index) {
          return buildTile(index);
        });
  }

  Widget buildTile(int index) {
    var data = widget.historicList[index];
    var icon = Icon(Icons.add_circle);
    var title = Text('${data['senderFirstName']} ${data['senderLastName']}');
    if (data['receiverAccountId'] != globals.currentUser['accountId']) {
      icon = Icon(Icons.remove_circle);
      title = Text('${data['receiverFirstName']} ${data['receiverLastName']}');
    }
    return ListTile(
        leading: icon,
        title: title,
        subtitle: Text(data['description']),
        trailing: Text('\$ ${data['amount'].toString()}'),
        onTap: () => _toggle(index));
  }
}
