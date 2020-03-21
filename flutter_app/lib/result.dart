import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function restartQuiz;

  Result(this.resultScore, this.restartQuiz);

  String get resultPhrase {
    String resultText;
    if (resultScore >= 16) {
      resultText = 'You are awesome and innocent';
    } else if (resultScore >= 12) {
      resultText = 'You are likable';
    } else if (resultScore >= 8) {
      resultText = 'You are ... strange?';
    } else {
      resultText = 'You are strange.';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('Restart Quiz!'),
            onPressed: restartQuiz,
            textColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
