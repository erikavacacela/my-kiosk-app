import 'package:buy_kiosko/clients/account_client.dart';
import 'package:buy_kiosko/pages/balance_page.dart';
import 'package:buy_kiosko/pages/collect_page.dart';
import 'package:buy_kiosko/pages/scan_qr_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static AccountClient accountClient = AccountClient();
  static List<Widget> _pageList = <Widget>[
    BalancePage(amount: "0.00"),
    ScanQRPage(),
    CollectPage()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(TextSpan(children: [
          WidgetSpan(child: Image.asset('assets/images/wallet-icon-32.png')),
          TextSpan(text: " Monedero Digital "),
        ])),
      ),
      body: _pageList[_selectedIndex],
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget bottomNav() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pagar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_received),
            label: 'Cobrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            print('Selected index: ${_selectedIndex}');
            if (index == 0) {
              updateAmount();
            }
          });
        });
  }

  Future<void> updateAmount() async {
    Map response = await accountClient.findByCurrentUser();
    if (response['id'] != null) {
      setState(() {
        var currentAmount = response['amount'].toString();
        _pageList[0] = BalancePage(amount: currentAmount);
        print('New amount: \$ $currentAmount');
      });
    }
  }
}
