import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/registration_provider.dart';
import 'package:social_media/screens/login_screen.dart';

class RegisterStudentScreen extends StatelessWidget {
  BuildContext loginScreenContext;

  RegisterStudentScreen(this.loginScreenContext);

  static String registerStudentScreenRout = '/register_student';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegistrationProvider provider = Provider.of<RegistrationProvider>(context);

    String extractUsername(String email) {
      String username = "";
      for (int i = 0; i < email.length; i++) {
        if (email[i] == "@") {
          break;
        }
        username += email[i];
      }
      return username;
    }

    //TODO :Temporary Solution TO IDENTIFY SRM STUDENT, USE VALIDATION and Change This SNACKBAR

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
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password')),
              ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.contains("@srmist.edu.in")) {
                      provider.registerStudent(
                          name: _nameController.text,
                          userName: extractUsername(_emailController.text),
                          email: _emailController.text,
                          password: _passwordController.text);
                      Navigator.pop(loginScreenContext);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => LoginScreen(
                                    loginPageContext: loginScreenContext,
                                  )));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please Login with you SRM ID")));
                    }
                  },
                  child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }
}
