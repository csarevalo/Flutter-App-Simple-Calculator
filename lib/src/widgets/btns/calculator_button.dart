// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String btnLabel;
  // final Color fillColor;
  // final ButtonStyle? btnStyle;
  final int selBtnStyle;
  final Function callback;

  const CalculatorButton({
    super.key,
    required this.btnLabel,
    required this.callback,
    // this.btnStyle,
    this.selBtnStyle = 0,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var styleList = <ButtonStyle?>[
      ElevatedButton.styleFrom(
        //default style for number keys
        foregroundColor: theme.colorScheme.inverseSurface,
        backgroundColor: theme.colorScheme.onInverseSurface,
        //(default) foregroundColor = theme.colorScheme.surfaceTint,
        //(default) backgroundColor = theme.colorScheme.surface,
      ),
      ElevatedButton.styleFrom(
        //style for operators
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      ElevatedButton.styleFrom(
        //style for quick actions (Del)
        foregroundColor: theme.colorScheme.onErrorContainer,
        backgroundColor: theme.colorScheme.errorContainer,
      ),
      ElevatedButton.styleFrom(
        //style for occasional actions (AC / C)
        foregroundColor: theme.colorScheme.onTertiaryContainer,
        backgroundColor: theme.colorScheme.tertiaryContainer,
      ),
    ];
    return SizedBox(
      height: 70,
      width: 70,
      child: ElevatedButton(
        onPressed: () => callback(btnLabel),
        style: styleList[selBtnStyle],
        child: Text(btnLabel),
      ),
    );
  }
}
