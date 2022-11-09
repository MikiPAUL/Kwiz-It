import 'package:flutter/material.dart';
import '../../Login/login_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "nothing",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            child: Icon(IconData(0xe09b, fontFamily: 'MaterialIcons', matchTextDirection: true)),
            // child: Text(
            //   "Enter".toUpperCase(),
            // ),
          ),
        ),
        const SizedBox(height: 16),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return SignUpScreen();
        //         },
        //       ),
        //     );
        //   },
        //   style: ElevatedButton.styleFrom(
        //       primary: kPrimaryLightColor, elevation: 0),
        //   child: Text(
        //     "Sign Up".toUpperCase(),
        //     style: TextStyle(color: Colors.black),
        //   ),
        // ),
      ],
    );
  }
}
