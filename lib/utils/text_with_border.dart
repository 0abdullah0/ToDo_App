import 'package:flutter/material.dart';

import 'constants.dart';

class TextWithBorder extends StatelessWidget {
  final String? text;
  final Color? borderColor;

  const TextWithBorder({Key? key,this.text, this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: borderColor! ,
              width: 5.0,
            ),
          )
      ),
      child: Text(text!,
        style: const TextStyle(
          fontSize: 20,
          color: Constants.secColor,
          fontWeight: FontWeight.bold
      ),),
    );
  }

}
