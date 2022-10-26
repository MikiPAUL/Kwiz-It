import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "KwizIt",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: kPrimaryColor,
          ),
        ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 7,
              child: Image.asset(
                'assets/images/univ.jpg',
              )
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 5),
      ],
    );
  }
}