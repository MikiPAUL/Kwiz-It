import 'dart:core';

class Question{
  late int questionNumber;
  late String question;
  late List<String> options;
  late int correctOptionsIndex;
  late int selectOptionsIndex;

  Question(this.questionNumber, this.question, this.options, this.correctOptionsIndex);

  String get getQuestion{
    return question;
  }
  set setQuestion(String question){
    this.question = question;
  }
  set setQuestionNumber(int questionNumber){
    this.questionNumber = questionNumber;
  }
  int get getQuestionNumber{
    return questionNumber;
  }
  List<String> get getOptions{
    return options;
  }
  set setOptions(List<String> options){
    this.options = options;
  }
  int get getCorrectOptionsIndex{
    return correctOptionsIndex;
  }
  set setCorrectOptionsIndex(int correctOptionsIndex){
    this.correctOptionsIndex = correctOptionsIndex;
  }
}

List<String> op = [
  "Sundar Pichai",
  "Arvind Krishna",
  "Larry Ellison",
  "Shantanu Narayen"
];


List<Question> questions = [
  Question(1, "Who is the CEO of GOOGLE?", op, 1),
  Question(2, "Who is the CEO of IBM?", op, 2),
  Question(3, "Who is the CEO of Oracle?", op, 3),
  Question(4, "Who is the CEO of Adobe?", op, 4),
];