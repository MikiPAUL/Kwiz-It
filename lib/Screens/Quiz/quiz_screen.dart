import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants.dart';
import '../../models/quiz.dart';
import 'resultpage.dart';

void main() => runApp(const QuizPage());

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQn = 0,
      totalQn = quiz.numberOfQuestions,
      totalMark = 0;
  var currentPageValue = 0.0;
  late List<int> selectedIndex = List<int>.filled(quiz.numberOfQuestions, -1, growable: false);
  void resetQuiz(){
    setState(() {
      currentQn = 0;
      totalMark = 0;
      selectedIndex = List<int>.filled(quiz.numberOfQuestions, -1, growable: false);
    });
  }
  PageController controller = PageController();
  void _selectOption(int index, int option) {
    if (selectedIndex[index] == option) {
      setState(() {
        selectedIndex[index] = -1;
      });
    }
    else {
      setState(() {
        selectedIndex[index] = option;
      });
    }
  }

  Widget _buildOptions(int index, int option) {
    return GestureDetector(
      onTap: () => _selectOption(index,option),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 13.0),
        decoration: BoxDecoration(
          color: (selectedIndex[index] != option) ? kPrimaryLightColor : kPrimaryColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kPrimaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              quiz.listOfQuestions[currentQn].options[option],
              style: TextStyle(
                fontSize: 17,
                color: (selectedIndex[index] != option) ? Colors.black87 : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isEveryQuestionAnswered(){
    for (var option in selectedIndex) {
      if(option == -1){
        return false;
      }
    }
    return true;
  }
  void calculateMark(){
    for(int i = 0; i < quiz.numberOfQuestions; i++){
      if(selectedIndex[i]+1 == quiz.listOfQuestions[i].correctOptionsIndex){
        totalMark++;
      }
    }
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  Widget checkForNextPage(int index) {
    if(index+1 ==  quiz.numberOfQuestions && isEveryQuestionAnswered()){
      for( var i in selectedIndex){
        print("$i \n");
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: (){
                calculateMark();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultPage(score: totalMark, total: quiz.numberOfQuestions)));
              },
              child: Text("SUBMIT",
              ),
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) => kPrimaryColor),
            ),
          ),
        ],
      );
    }
    else if(selectedIndex[index] != -1 && index+1 != quiz.numberOfQuestions) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Row(
          children: [
            (index==0)?Icon(IconData(0xf057a, fontFamily: 'MaterialIcons')):Text(""),
            SizedBox(width: 15,),
            (index==0)?Text("Next Question",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
            ):Text(""),
          ],
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SmoothPageIndicator(
                count: quiz.numberOfQuestions,
                effect: const WormEffect(
                  spacing: 16,
                  dotColor: kPrimaryLightColor,
                  activeDotColor: kPrimaryColor,
                )
                , controller: controller,
              ),
            )
          ],
        ),
      ),
      body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                child: PageView.builder(
                    itemCount: totalQn,
                    controller: controller,
                    // physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index){
                      setState(() {
                        currentQn = index;
                      });
                    },
                    itemBuilder: (context, currentQns) {
                      //print("${quiz.listOfQuestions[currentQns].question} ");
                      final question = quiz.listOfQuestions[currentQns].question;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Questions ${currentQns+1}/$totalQn",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: kPrimaryColor,
                              )),
                          const SizedBox(height: 15),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(question,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: quiz.listOfQuestions[currentQns].options
                                .map((option) => _buildOptions(currentQns, quiz.listOfQuestions[currentQns].options.indexOf(option)))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          checkForNextPage(currentQns),
                        ],
                      );
                    }),
              ))
        ],
      ),
    ));
  }
}

