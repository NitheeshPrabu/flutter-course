import 'package:flutter/material.dart';

import '../blocs/bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(),
          passwordField(),
          SizedBox(height: 25.0),
          submitButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'you@example.com',
        labelText: 'Email Address',
      ),
    );
  }

  Widget passwordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'password',
        labelText: 'Password',
      ),
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: const Text('Login'),
      onPressed: () {},
    );
  }
}
