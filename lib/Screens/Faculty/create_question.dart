import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Quiz/quiz_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/models/quiz_model.dart';
import '/constants.dart';
import 'package:flutter_auth/Screens/Faculty/faculty_page.dart';

List<Question> questions = [];
late Quiz quiz;
final TextEditingController questionName = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuestionPage(),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  static int qn = 0;
  late List<TextEditingController> _options =
      List.generate(4, (i) => TextEditingController());
  final TextEditingController _correctIndex = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Question",
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: questions
                    .map(
                      (qn) => showQuestions(qn),
                    )
                    .toList(),
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.add),
                      onTap: () {
                        _displayDialog();
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "add questions",
                      style: setDefaultStyle(),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                onPressed: () {
                  if (questions.length == 0) {
                    Fluttertoast.showToast(
                      msg: "Can't create a empty Quiz",
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
                    quiz = Quiz.constructor(dropDownValue, selectedBranch,
                        quizName!, questions.length, questions);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => QuizPage()));
                  }
                },
                child: Text("Create Quiz",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showQuestions(Question q) {
    int index = questions.indexOf(q);
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("${index + 1} )", style: setDefaultStyle()),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 6,
              child: Text(
                q.question,
                style: setDefaultStyle(),
                softWrap: true,
              ),
            ),
            Spacer(),
            GestureDetector(
              child: EditButton(
                questionNumber: qn,
                onPressed: buttonFunction,
                icon: Icon(
                  Icons.edit,
                ),
              ),
              // onTap: openEditMode(),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: questions[index]
              .options
              .map(
                (option) => showOptions(option),
              )
              .toList(),
        )
      ],
    ));
  }

  Widget showOptions(String option) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            option,
            style: TextStyle(
              fontSize: 17,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle setDefaultStyle() {
    return TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: kPrimaryColor,
    );
  }

  Future<void> _editDialog(int id) async {
    Question currQn = questions[id];
    questionName.text = currQn.question;
    _options = List.generate(4, (i) => TextEditingController());
    _options[0].text = currQn.options[0];
    _options[1].text = currQn.options[1];
    _options[2].text = currQn.options[2];
    _options[3].text = currQn.options[3];
    _correctIndex.text = currQn.correctOptionsIndex.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Question',
            style: setDefaultStyle(),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: questionName,
                  decoration: const InputDecoration(hintText: 'Enter Question'),
                ),
                Column(
                  children: _options.asMap().entries.map((entry) {
                    int index = entry.key;
                    var option = entry.value;
                    return buildTextField(index, option);
                  }).toList(),
                ),
                TextField(
                  controller: _correctIndex,
                  decoration: const InputDecoration(
                      hintText: 'Enter Correct Option Index'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: Text('Cancel', style: TextStyle(color: kPrimaryColor)),
                  onPressed: () {
                    setState(() {
                      _correctIndex.clear();
                      questionName.clear();
                      _options.clear();
                      _options =
                          List.generate(4, (i) => TextEditingController());
                    });
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 120,
                ),
                TextButton(
                  child: Text(
                    'Save',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  onPressed: () {
                    _saveQuestion(id);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _saveQuestion(int id) {
    setState(() {
      questions[id].correctOptionsIndex = int.parse(_correctIndex.text);
      questions[id].question = questionName.text;
      questions[id].options[0] = _options[0].text;
      questions[id].options[1] = _options[1].text;
      questions[id].options[2] = _options[2].text;
      questions[id].options[3] = _options[3].text;
      _correctIndex.clear();
      questionName.clear();
      _options.clear();
      _options = List.generate(4, (i) => TextEditingController());
    });
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Questions',
            style: setDefaultStyle(),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: questionName,
                  decoration: const InputDecoration(hintText: 'Enter Question'),
                ),
                Column(
                  children: _options.asMap().entries.map((entry) {
                    int index = entry.key;
                    var option = entry.value;
                    return buildTextField(index, option);
                  }).toList(),
                ),
                TextField(
                  controller: _correctIndex,
                  decoration: const InputDecoration(
                      hintText: 'Enter Correct Option Index'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: Text('Cancel', style: TextStyle(color: kPrimaryColor)),
                  onPressed: () {
                    setState(() {
                      _correctIndex.clear();
                      questionName.clear();
                      _options.clear();
                      _options =
                          List.generate(4, (i) => TextEditingController());
                    });
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 120,
                ),
                TextButton(
                  child: Text(
                    'Add',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  onPressed: () {
                    _addQuestion();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildTextField(int index, var option) {
    return TextField(
      controller: _options[index],
      decoration: const InputDecoration(hintText: 'Enter the option'),
    );
  }

  void _addQuestion() {
    qn += 1;
    setState(() {
      questions.add(Question.constructor(
          qn,
          questionName.text,
          _options.map((e) => e.text.toString()).toList(),
          int.parse(_correctIndex.text)));
      _correctIndex.clear();
      questionName.clear();
      _options.clear();
      _options = List.generate(4, (i) => TextEditingController());
    });
  }

  buttonFunction(id) {
    _editDialog(id - 1);
  }
}

class EditButton extends StatelessWidget {
  late int questionNumber;
  final Function(int) onPressed;
  final Icon icon;

  EditButton(
      {required this.questionNumber,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          onPressed(this.questionNumber);
        },
        backgroundColor: kPrimaryLightColor,
        child: Icon(Icons.edit, color: kPrimaryColor,));
  }
}
