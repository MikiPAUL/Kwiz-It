import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Faculty/show_leader_board.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/constants.dart';
import '/Screens/Faculty/create_question.dart';

String dropDownValue = '2018';
String selectedBranch = 'it';
String? quizName;
String duration = "15 mins";

class CreateQuiz extends StatelessWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizDetails(),
    );
  }
}

class QuizDetails extends StatefulWidget {
  const QuizDetails({Key? key}) : super(key: key);

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // List of items in our dropdown menu
  var items = [
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
  ];
  var durationList = [
    '5 mins',
    '10 mins',
    '15 mins',
    '20 mins',
    '25 mins',
    '30 mins'
  ];
  DateTime time = DateTime.now();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _controller.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Quiz"),
        backgroundColor: kPrimaryColor,
      ),
      drawer: createDrawer(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  getQuizName(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Select batch",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      buildBatchGetter(),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "BRANCH",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Divider(
                      thickness: 2,
                      color: kPrimaryColor,
                    ),
                  ),
                  branchList(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Select duration",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      DropdownButton(
                        // Initial Value
                        value: duration,
                        iconEnabledColor: kPrimaryColor,
                        dropdownColor: kPrimaryLightColor,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: durationList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            duration = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (quizName == null || quizName?.isEmpty == true) {
                        Fluttertoast.showToast(
                          msg: "Enter the quiz name",
                          // message
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: kPrimaryColor,
                          webPosition: "Center",
                          webBgColor:
                              "linear-gradient(to bottom, #ff0000 100%, #ff0000 58%);",
                        );
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      }
                    },
                    child: Text(
                      "NEXT",
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getQuizName() {
    return Row(
      children: [
        Spacer(),
        Expanded(
          flex: 10,
          child: TextFormField(
            cursorColor: kPrimaryColor,
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fillColor: Colors.grey,
              hintText: "Enter the Quiz Name",
              labelText: 'Quiz Name',
              labelStyle: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (val) {
              quizName = val;
            },
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget createDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Faculty"),
            accountEmail: Text("Faculty ID"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: kPrimaryLightColor,
              child: Text(
                "Profile Photo",
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
             // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.leaderboard),
            title: Text("Show Leaderboard"),
            onTap: () {
              Navigator.of(context).push((MaterialPageRoute(builder: (context) => ShowLeaderBoard())));
            },
          ),
        ],
      ),
    );
  }

  Widget buildBatchGetter() {
    return DropdownButton(
      // Initial Value
      value: dropDownValue,
      iconEnabledColor: kPrimaryColor,
      dropdownColor: kPrimaryLightColor,
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropDownValue = newValue!;
        });
      },
    );
  }

  Widget branchList() {
    return Column(
      children: [
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("CS"),
          value: "cs",
          groupValue: selectedBranch,
          onChanged: (value) {
            setState(() {
              selectedBranch = value.toString();
            });
          },
        ),
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("IT"),
          value: "it",
          groupValue: selectedBranch,
          onChanged: (value) {
            setState(() {
              selectedBranch = value.toString();
            });
          },
        ),
        RadioListTile(
          activeColor: kPrimaryColor,
          title: Text("Both"),
          value: "both",
          groupValue: selectedBranch,
          onChanged: (value) {
            setState(() {
              selectedBranch = value.toString();
            });
          },
        )
      ],
    );
  }
}
