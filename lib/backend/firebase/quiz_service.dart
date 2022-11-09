import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Quiz/quiz_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/quiz_model.dart';

late Quiz quiz;

class GetQuiz extends StatelessWidget {
  final String documentId;

  GetQuiz(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference students =
        FirebaseFirestore.instance.collection('quiz');

    return FutureBuilder<DocumentSnapshot>(
      //Fetching data from the documentId specified of the student
      future: students.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/main_top.png',
                      ),
                      height: 130,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            height: 350,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/noquiz.jpeg"),
                                //fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
                        ],
                      ),
                    ),
                  ],
                ),
                //body: Center(
                  // child: Text(
                  //   "Keep Calm\n"
                  //   "There is no\n"
                  //   "Quiz\n"
                  //   "Today!!!\n",
                  //   style: TextStyle(
                  //     fontSize: 28,
                  //     fontWeight: FontWeight.bold,
                  //     color: kPrimaryColor,
                  //   ),
                  // ),
                //),
              ));
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data!.exists) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          quiz = Quiz.fromJson(data);
          return QuizScreen();
          //   return Text("$data[listOfQuestions]");
        }

        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}
