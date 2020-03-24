import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/HttpException.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/$urlSegment?key=AIzaSyAMQrm6tlzA6bmjSDmBxDQJ0Fqp8aJKsr4';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final body = json.decode(response.body);
      if (body['error'] != null) {
        throw HttpException(body['error']['message']);
      }
      _token = body['idToken'];
      _userId = body['localId'];
      _expiryDate = DateTime.now().add(Duration(
        seconds: int.parse(body['expiresIn']),
      ));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'accounts:signUp');
  }

  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, 'accounts:signInWithPassword');
  }
}
