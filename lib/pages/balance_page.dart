import 'package:buy_kiosko/clients/account_client.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  BalancePage() : super();

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  AccountClient accountClient = AccountClient();
  String _amount = "0,00";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        Text("Saldo actual", style: TextStyle(fontSize: 25)),
        const SizedBox(height: 70),
        MaterialButton(
          color: Colors.blue,
          shape: const CircleBorder(),
          onPressed: () {},
          child: Padding(
            padding: EdgeInsets.all(100),
            child: Text(
              '\$ $_amount',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> updateAmount() async {
    Map response = await accountClient.findByCurrentUser();
    if (response['id'] != null) {
      _amount = response['amount'];
    }
  }
}
