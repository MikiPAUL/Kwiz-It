import 'package:flutter/material.dart';
import '../../constants.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key? key, required this.score, required this.total,})
      : super(key: key);
  int score, total;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: const Alignment(0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "You got ${widget.score} mark out of ${widget.total}",
              style: const TextStyle(
                fontSize: 17,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
