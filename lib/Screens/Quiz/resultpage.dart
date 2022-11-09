import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';

class ResultPage extends StatefulWidget {
  ResultPage({
    Key? key,
    required this.score,
    required this.total,
  }) : super(key: key);
  int score, total;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/main_top.png',
              ),
              height: 100,
            ),
          ),
          Container(
            alignment: Alignment(0.0, 0.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "CONGRATULATIONS!!!",
                  style: const TextStyle(
                    fontSize: 24,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Image.asset(
                  'assets/images/medal.png',
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Your Score: ${widget.score}/${widget.total}",
                  style: const TextStyle(
                    fontSize: 23,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30,),

                Container(
                  height: 40,
                  width: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      },
                      child: Text(
                        "Exit"
                      ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
                    ),
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/images/login_bottom.png',
                  ),
                  alignment: Alignment.bottomRight,
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
