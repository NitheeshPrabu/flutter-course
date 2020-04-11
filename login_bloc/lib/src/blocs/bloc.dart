import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../mixins/validators.dart';

// mixins require an extend, because the mixins are applied to the parent class,
// and this `modified` parent class is then used to define the child class.
class Bloc extends Object with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => e != null && p != null);

  void submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;
    print('$validEmail, $validPassword');
  }

  void dispose() {
    _email.close();
    _password.close();
  }
}
