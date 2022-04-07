import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error!'));
        }

        return snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.pink,
                  backgroundColor: Colors.pink,
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: Colors.deepPurple,
                    // brightness: Brightness.dark,
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                initialRoute: '/',
                // initialRoute: AuthScreen.routeName,
                routes: {
                  '/': (BuildContext ctx) => StreamBuilder(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (BuildContext ctx,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            return const ChatScreen();
                          }
                          return const AuthScreen();
                        },
                      ), // AuthScreen.routeName: (BuildContext ctx) =>
                  //     const AuthScreen(),
                  // ChatScreen.routeName: (BuildContext ctx) =>
                  //     const ChatScreen(),
                },
              );
      },
    );
  }
}
