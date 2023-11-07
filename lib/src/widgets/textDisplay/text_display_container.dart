import 'package:flutter/material.dart';

class TextDisplayContainer extends StatelessWidget {
  const TextDisplayContainer({
    super.key,
    required this.inputText,
    required this.textType,
  });

  final String inputText;
  final int textType;

  @override
  Widget build(BuildContext context) {
    double? width;
    double alignX = 1.0;
    double edgRight = 12;
    double edgBottom = 12;
    TextStyle? textStyle;
    int? maxLines;
    switch (textType) {
      case 1:
        width = 350;
        alignX = 0.6;
        edgRight = 16;
        edgBottom = 11;
        maxLines = null;
        textStyle = TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          color: Theme.of(context).colorScheme.secondary,
        );
      case 2:
        width = 350;
        alignX = 0.6;
        edgRight = 12;
        edgBottom = 3;
        maxLines = 1;
        textStyle = TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          color: Theme.of(context).colorScheme.secondary,
        );
      case 3:
        width = 380;
        alignX = 0.6;
        edgRight = 12;
        edgBottom = 12;
        maxLines = 1;
        textStyle = TextStyle(
          fontFamily: 'Poppins',
          fontSize: 48,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        );
      default:
        throw Exception('Invalid Case');
    }

    return Container(
      alignment: Alignment(alignX, 1.0),
      padding: EdgeInsets.only(right: edgRight, bottom: edgBottom),
      child: SizedBox(
        width: width,
        child: Text(
          inputText,
          textAlign: TextAlign.right,
          maxLines: maxLines,
          style: textStyle,
        ),
      ),
    );
  }
}
