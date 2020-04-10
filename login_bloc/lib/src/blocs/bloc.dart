import 'dart:async';

import '../mixins/validators.dart';

// mixins require an extend, because the mixins are applied to the parent class,
// and this `modified` parent class is then used to define the child class.
class Bloc extends Object with Validators {
  final _emailController = StreamController<String>();
  final _passwordController = StreamController<String>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
