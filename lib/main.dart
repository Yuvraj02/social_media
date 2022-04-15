import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/registration_provider.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/screens/screens_handler.dart';
import 'package:social_media/utilities/auth_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context)=>RegistrationProvider(),)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: AuthHelper.user == null?LoginScreen():ScreenHandler(),
        // routes: {
        //   '/login':(context) => LoginScreen(),
        //   '/register_student':(context) => RegisterStudentScreen(),
        //   '/home_screen':(context)=>HomeScreen(),
        // },
      ),
    );
  }
}
