import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function onPressHandler;
  final String answerText;

  Answer(this.onPressHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(this.answerText),
        onPressed: onPressHandler,
      ),
    );
  }
}
