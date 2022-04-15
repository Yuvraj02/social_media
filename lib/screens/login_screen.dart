import 'package:flutter/material.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/newUserScreens/club_selection_screen.dart';
import 'package:social_media/screens/register_student_screen.dart';
import 'package:social_media/screens/screens_handler.dart';
import 'package:social_media/utilities/auth_helper.dart';
import 'package:social_media/utilities/navigation_helper.dart';

class LoginScreen extends StatefulWidget {

  BuildContext? loginPageContext;

  LoginScreen({this.loginPageContext});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final textFormFieldDecoration = const InputDecoration(label: Text("Input Text"), hintText: 'Hint Text');

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: textFormFieldDecoration.copyWith(
                    label: const Text("Email"),
                    hintText: 'Enter Your SRM Email ID here'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: textFormFieldDecoration.copyWith(
                    label: Text("Password"), hintText: 'Enter Your Password'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context,
                        //     RegisterStudentScreen.registerStudentScreenRout);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RegisterStudentScreen(context)));
                      },
                      child: Text("Register as Student")),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Register as Verified Entity",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.yellow)),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var user = await AuthHelper.logInUser(_emailController.text, _passwordController.text);

                    if (user != null) {
                      //print(newUser);
                      if (newUser) {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) =>
                            ClubSelectionNewUser(user)));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ScreenHandler()));
                     //   NavigationHelper.removeLoginPage(widget.loginPageContext);
                      }
                    }
                  },
                  child: Text("Login"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {}, child: Text("Forgot Password ?")),
                  TextButton(onPressed: () {}, child: Text("Contact Us"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
