import 'dart:core';
import '/Screens/Faculty/create_question.dart';

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

List<Question> qn = questions;