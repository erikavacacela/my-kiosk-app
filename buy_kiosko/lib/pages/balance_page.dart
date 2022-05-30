import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  BalancePage({required this.amount}) : super();

  final String amount;

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
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
          onPressed: () => {},
          child: Padding(
            padding: EdgeInsets.all(100),
            child: Text(
              '\$ ${widget.amount}',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ]),
    );
  }
}
