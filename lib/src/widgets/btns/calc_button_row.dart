// ignore_for_file: avoid_print

import 'package:calculator_app/src/widgets/btns/calculator_button.dart';
import 'package:flutter/material.dart';

class CalcButtonRow extends StatelessWidget {
  final List<String> btnsText;
  final List<int> selBtnsStyle;
  final Function onclick;
  const CalcButtonRow({
    super.key,
    required this.btnsText,
    required this.selBtnsStyle,
    this.onclick = print,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              btnLabel: btnsText[0],
              callback: onclick,
              selBtnStyle: selBtnsStyle[0],
            ),
            CalculatorButton(
              btnLabel: btnsText[1],
              callback: onclick,
              selBtnStyle: selBtnsStyle[1],
            ),
            CalculatorButton(
              btnLabel: btnsText[2],
              callback: onclick,
              selBtnStyle: selBtnsStyle[2],
            ),
            CalculatorButton(
              btnLabel: btnsText[3],
              callback: onclick,
              selBtnStyle: selBtnsStyle[3],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
