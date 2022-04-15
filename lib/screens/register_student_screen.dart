import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/utilities/auth_helper.dart';

class RegisterStudentScreen extends StatelessWidget {
  BuildContext loginScreenContext;

  RegisterStudentScreen(this.loginScreenContext);

  static String registerStudentScreenRout = '/register_student';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password')),
              ElevatedButton(
                  onPressed: () {
                    AuthHelper.registerUser(_nameController.text,
                            _emailController.text, _passwordController.text)
                        .then((value) => FirebaseFirestore.instance
                            .collection('users')
                            .doc(value!.uid).set({"email": value.email,
                                                  "uid":value.uid,
                                                  "name":value.displayName},));
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
