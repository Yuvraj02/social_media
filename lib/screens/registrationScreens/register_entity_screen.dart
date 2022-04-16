import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/registration_provider.dart';
import '../login_screen.dart';

class RegisterEntityScreen extends StatelessWidget {

  BuildContext loginScreenContext;

  RegisterEntityScreen(this.loginScreenContext);


  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    RegistrationProvider provider = Provider.of<RegistrationProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Club Name"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Club Email"),
              ),
              TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password')),
              ElevatedButton(
                  onPressed: () {
                    provider.registerEntity(_nameController.text, _emailController.text, _passwordController.text);
                    Navigator.pop(loginScreenContext);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LoginScreen(
                              loginPageContext: loginScreenContext,
                            )));
                  },
                  child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }
}
