import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Faculty/faculty_page.dart';
import 'package:flutter_auth/Screens/Quiz/quiz_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool submitValid = false;

  late EmailAuth emailAuth;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize the package
  //   emailAuth = new EmailAuth(
  //     sessionName: "Login session",
  //   );
  // }

  bool verify() {
    return emailAuth.validateOtp(
        recipientMail: _emailcontroller.value.text,
        userOtp: _otpcontroller.value.text);
  }

  /// a void function to send the OTP to the user
  /// Can also be converted into a Boolean function and render accordingly for providers
  void sendOtp() async {
   // String mailId = _emailcontroller.text + "@gmail.com";
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailcontroller.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  void _showToast() {
    Fluttertoast.showToast(
      msg: "Wrong OTP entered",  // message
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      webPosition: "Center",
      webBgColor: "linear-gradient(to bottom, #ff0000 100%, #ff0000 58%);",
    );
  }
 Widget build(BuildContext context){
   return Form(
     child: Column(
       children: [
         TextFormField(
           keyboardType: TextInputType.emailAddress,
           controller: _emailcontroller,
           textInputAction: TextInputAction.next,
           cursorColor: kPrimaryColor,
           onSaved: (email) {},
           decoration: InputDecoration(
               hintText: "Student/Faculty ID",
               prefixIcon: Padding(
                 padding: const EdgeInsets.all(defaultPadding),
                 child: Icon(Icons.person),
               ),
               suffixIcon: TextButton(
                 child: Text("send otp",
                  style: TextStyle(
                    fontSize: 17,
                    color: kPrimaryColor,
                  ),
                 ),
                 onPressed: () => sendOtp(),
               )
           ),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(vertical: defaultPadding),
           child: TextFormField(
             textInputAction: TextInputAction.done,
             controller: _otpcontroller,
             obscureText: true,
             cursorColor: kPrimaryColor,
             decoration: InputDecoration(
               hintText: "Enter OTP",
               prefixIcon: Padding(
                 padding: const EdgeInsets.all(defaultPadding),
                 child: Icon(Icons.lock),
               ),
             ),
           ),
         ),
         const SizedBox(height: defaultPadding),
         Hero(
           tag: "login_btn",
           child: ElevatedButton(
             onPressed: () {
               if(true){
                 if(_emailcontroller.text.length == 10){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizPage()));
                 }
                 else {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateQuiz()));
                 }
               }
               else{
                 _showToast();
               }
             },
             child: Text(
               "Login".toUpperCase(),
             ),
           ),
         ),
         const SizedBox(height: defaultPadding),
         // AlreadyHaveAnAccountCheck(
         //   press: () {
         //     Navigator.push(
         //       context,
         //       MaterialPageRoute(
         //         builder: (context) {
         //           return SignUpScreen();
         //         },
         //       ),
         //     );
         //   },
         // ),
       ],
     ),
   );
 }
}
