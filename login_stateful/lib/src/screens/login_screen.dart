import 'package:flutter/material.dart';

import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@example.com',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'password',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(email);
        }
      },
      color: Colors.blue,
      child: const Text('Submit'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            passwordField(),
            SizedBox(height: 25.0),
            submitButton(),
          ],
        ),
      ),
    );
  }
}
