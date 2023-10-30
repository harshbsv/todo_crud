import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_crud/views/auth/auth_gate.dart';
import 'package:todo_crud/views/home/home_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    PhoneAuthProvider(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo CRUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/auth',
      routes: {
        '/': (context) => const HomePage(),
        '/auth': (context) => const AuthGate(),
        // '/login': (context) => PhoneInputScreen(
        //       actions: [
        //         SMSCodeRequestedAction(
        //           (context, action, flowKey, phoneNumber) {
        //             Navigator.of(context).push(
        //               MaterialPageRoute(
        //                 builder: (context) => SMSCodeInputScreen(
        //                   flowKey: flowKey,
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       ],
        //     ),
      },
    );
  }
}
