import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import '../Quiz/quiz_screen.dart';

late Map<String, String> result;

class ShowLeaderBoard extends StatefulWidget {
  const ShowLeaderBoard({Key? key}) : super(key: key);
  @override
  State<ShowLeaderBoard> createState() => _ShowLeaderBoardState();
}

class _ShowLeaderBoardState extends State<ShowLeaderBoard> {

  // void sortResult() {
  //   result.sort((a,b) => b['score'].compareTo(a['score']));
  // }

  @override
  Widget build(BuildContext context) {
    CollectionReference students =
    FirebaseFirestore.instance.collection('score');

    return FutureBuilder<DocumentSnapshot>(
      //Fetching data from the documentId specified of the student
      future: students.doc('jathi').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Scaffold(
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
              );
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData &&
            snapshot.data!.exists) {
          Map<String, dynamic> result =
          snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            body: Column(
              children: [
                Container(
                    child: Image.asset('assets/images/signup_top.png'),
                    height: 100,
                  alignment: Alignment.topLeft,
                ),
                Padding(
                  padding: const EdgeInsets.all(19),
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset('assets/images/trophy.jpg'),
                        height: 150,
                      ),
                      SizedBox(height: 40,),
                      DataTable(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        dividerThickness: 3,
                        dataRowHeight: 50,
                        columnSpacing: 70,
                        headingRowColor:
                        MaterialStateColor.resolveWith((states) => kPrimaryColor),
                        columns: [
                          DataColumn(label: Text("Roll Number", style: defaultStyle())),
                          DataColumn(label: Text("Score", style: defaultStyle())),
                        ],
                        // rows: result // Loops through dataColumnText, each iteration assigning the value to element
                        //     .map(
                        //   ((element) => DataRow(
                        //     cells: <DataCell>[
                        //       DataCell(Text(element["rollno"])), //Extracting from Map element the value
                        //       DataCell(Text(element["score"])),
                        //     ],
                        //   )),
                        // )
                        //     .toList(),
                        rows: [
                          DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(result["rollno"])), //Extracting from Map element the value
                                  DataCell(Text(result["obtained_score"])),
                                ],
                              )
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(IconData(0xf82c, fontFamily: 'MaterialIcons')),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateColor.resolveWith((states) => kPrimaryColor),
                  ),
                  // child: Text(
                  //   "Enter".toUpperCase(),
                  // ),
                ),
                Spacer()
              ],
            ),
          );
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
  defaultStyle(){
    return TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
  }
}
