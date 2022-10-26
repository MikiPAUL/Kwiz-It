import 'dart:core';
import '../Screens/Faculty/create_question.dart';
import '../Screens/Faculty/question.dart';

class Quiz{
  late String quizName;
  late int numberOfQuestions;
  late List<Question> listOfQuestions;

  Quiz(this.quizName, this.numberOfQuestions, this.listOfQuestions);

  set setQuizName(String quizName){
    this.quizName = quizName;
  }
  String get getQuizName{
    return quizName;
  }
  set setNumberOfQuestions(int numberOfQuestions){
    this.numberOfQuestions = numberOfQuestions;
  }
  int get getNumberOfQuestions{
    return numberOfQuestions;
  }
  set setListOfQuestions(List<Question> listOfQuestions){
    this.listOfQuestions = listOfQuestions;
  }
  List<Question> get getListOfQuestions{
    return listOfQuestions;
  }

}

Quiz quiz = Quiz(questionName.text, qn.length , qn);





