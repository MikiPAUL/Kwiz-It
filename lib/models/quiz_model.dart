import 'dart:convert';

Quiz quizModelFromJson(String str) => Quiz.fromJson(json.decode(str));

String quizModelToJson(Quiz data) => json.encode(data.toJson());

class Quiz {
  Quiz({
    this.quizid,
    required this.batch,
    required this.branch,
    required this.quizName,
    required this.numberOfQuestions,
    required this.listOfQuestions,
  });
  Quiz.constructor(
      this.batch,
      this.branch,
      this.quizName,
      this.numberOfQuestions,
      this.listOfQuestions,);

  String? quizid;
  String batch;
  String branch;
  String quizName;
  int numberOfQuestions;
  List<Question> listOfQuestions;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    quizid: json["quizid"],
    batch: json["batch"],
    branch: json["branch"],
    quizName: json["quizName"],
    numberOfQuestions: json["numberOfQuestions"],
    listOfQuestions: List<Question>.from(json["listOfQuestions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quizid": quizid,
    "batch": batch,
    "branch": branch,
    "quizName": quizName,
    "numberOfQuestions": numberOfQuestions,
    "listOfQuestions": List<dynamic>.from(listOfQuestions.map((x) => x.toJson())),
  };
}

class Question {
  Question({
    required this.questionNumber,
    required this.question,
    required this.options,
    required this.correctOptionsIndex,
    this.selectOptionsIndex
  });
  Question.constructor(
      this.questionNumber,  this.question, this.options, this.correctOptionsIndex
      );
  int questionNumber;
  String question;
  List<String> options;
  int correctOptionsIndex;
  String? selectOptionsIndex;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionNumber: json["questionNo"],
    question: json["question"],
    options: List<String>.from(json["options"].map((x) => x)),
    correctOptionsIndex: json["correctOptionIndex"],
  );

  Map<String, dynamic> toJson() => {
    "questionNo": questionNumber,
    "question": question,
    "options": List<dynamic>.from(options.map((x) => x)),
    "correctOptionIndex": correctOptionsIndex,
  };
}
