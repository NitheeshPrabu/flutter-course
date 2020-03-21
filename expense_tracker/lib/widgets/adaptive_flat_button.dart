import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function onPressHandler;

  AdaptiveFlatButton({this.text, this.onPressHandler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: onPressHandler,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: onPressHandler,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
