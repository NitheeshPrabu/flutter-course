import 'package:flutter/material.dart';

import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          SizedBox(height: 25.0),
          submitButton(bloc),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'you@example.com',
            labelText: 'Email Address',
            errorText: snapshot.error,
          ),
        );
      },
      stream: bloc.email,
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'password',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
        );
      },
      stream: bloc.password,
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return RaisedButton(
          color: Colors.blue,
          child: const Text('Login'),
          onPressed: !snapshot.hasData ? null : bloc.submit,
        );
      },
      stream: bloc.submitValid,
    );
  }
}
