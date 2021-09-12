import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:konsolto_task/utils/constants.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 130),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              "Come on add some tasks and let's get things done",
              textStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Constants.sideColor,
              ),
              textAlign: TextAlign.justify,
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
          pause: const Duration(milliseconds: 1),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
      )
    );
  }
}
