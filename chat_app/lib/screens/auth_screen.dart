import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitForm(
    BuildContext ctx,
    String email,
    String password,
    String? username,
    bool _isLogin,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({
          'email': email,
          'username': username,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An Error occured, please check your credentials';

      if (err.message != null) {
        message = err.message as String;
      }

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
          action: SnackBarAction(
            label: 'Okay',
            onPressed: () {},
          ),
        ),
      );
    } catch (err) {
      var message = err.toString();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
          action: SnackBarAction(
            label: 'Okay',
            onPressed: () {},
          ),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitFn: _submitForm, isLoading: _isLoading),
    );
  }
}
