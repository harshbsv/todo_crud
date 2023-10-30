import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_crud/views/home/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Text(
                    'Todo CRUD',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.purple,
                    ),
                  ),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Todo CRUD, please sign in!')
                    : const Text('Welcome to Todo CRUD, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Text(
                    'Todo CRUD',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.purple,
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const HomePage();
      },
    );
  }
}
