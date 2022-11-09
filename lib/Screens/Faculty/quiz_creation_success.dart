import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '/constants.dart';

class CreationSuccess extends StatefulWidget {
  const CreationSuccess({Key? key}) : super(key: key);

  @override
  State<CreationSuccess> createState() => _CreationSuccessState();
}

class _CreationSuccessState extends State<CreationSuccess> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/main_top.png',
            ),
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Text("Congratulations 😃",
                    style: defaultStyling()
                ),

                SizedBox(height: 25,),
                Center(
                  child: Image.asset(
                    'assets/images/success.png',
                    scale: 2,
                  ),
                ),
                SizedBox(height: 30,),
                Text("Quiz Created\n"
                    "Successfully!!!",
                    style: defaultStyling()
                ),
                SizedBox(height: 30,),
                ElevatedButton(
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

              ],
            ),
          ),
          Container(
            child: Image.asset(
              'assets/images/login_bottom.png',
              scale: 0.2,
            ),
            alignment: Alignment.bottomRight,
            height: 80,
          ),
        ],
      ),
    );
  }
}


defaultStyling(){
  return const TextStyle(
    fontSize: 27,
    color: kPrimaryColor,
    fontWeight: FontWeight.bold,
  );
}