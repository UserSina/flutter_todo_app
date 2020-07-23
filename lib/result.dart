import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetQuiz;

  Result({this.totalScore, this.resetQuiz});

  String get getResult {
    if (totalScore <= 8) {
      return "Yay, result A !";
    } else if (totalScore <= 12) {
      return "Yay, result B !";
    } else if (totalScore <= 16) {
      return "Yay, result C !";
    } else {
      return "Yay, result D !";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            getResult,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text(
              'Restart',
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.blue,
            onPressed: resetQuiz,
          ),
        ],
      ),
    );
  }
}
