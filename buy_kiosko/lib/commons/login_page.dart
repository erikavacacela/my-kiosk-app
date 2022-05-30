import 'package:buy_kiosko/clients/login_client.dart';
import 'package:buy_kiosko/commons/home_page.dart';
import 'package:flutter/material.dart';
import 'package:buy_kiosko/utils/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  LoginPage() : super();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Monedero Digital"),
        ),
        body: LoginFormWidget());
  }
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  var loginClient = LoginClient();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(50),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/wallet-icon.png'),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Bienvenido',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Usuario',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el usuario';
                        }
                        return null;
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Contraseña',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese la contraseña';
                        }
                        return null;
                      }),
                ),
                const SizedBox(height: 30),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Iniciar Sesión'),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          showMessageOrRedirect(context, nameController.text,
                              passwordController.text);
                        }
                      },
                    ))
              ],
            )));
  }

  Future<void> showMessageOrRedirect(
      context, String username, String password) async {
    Map response = await loginClient.login(username, password);
    if (response['id'] == null) {
      showMessage(context, 'Usuario o contraseña incorrectos.');
    } else if (response['error'] != null) {
      showMessage(context, response['error']);
    } else {
      globals.isLoggedIn = true;
      globals.currentUser = response;
      print('Go to home');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HomePage(title: 'Pagos en mi Kiosko')));
    }
  }

  void showMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
