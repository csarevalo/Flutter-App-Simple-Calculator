import 'package:calculator_app/src/widgets/btns/calc_button_row.dart';
import 'package:flutter/material.dart';

class CalcKeys extends StatelessWidget {
  final Function callback;

  const CalcKeys({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalcButtonRow(
          btnsText: const ['AC', 'C', 'Del', '/'],
          selBtnsStyle: const [3, 3, 2, 1],
          onclick: callback,
        ),
        CalcButtonRow(
          btnsText: const ['7', '8', '9', 'x'],
          selBtnsStyle: const [0, 0, 0, 1],
          onclick: callback,
        ),
        CalcButtonRow(
          btnsText: const ['4', '5', '6', '–'],
          selBtnsStyle: const [0, 0, 0, 1],
          onclick: callback,
        ),
        CalcButtonRow(
          btnsText: const ['1', '2', '3', '+'],
          selBtnsStyle: const [0, 0, 0, 1],
          onclick: callback,
        ),
        CalcButtonRow(
          btnsText: const ['+/-', '0', '.', '='],
          selBtnsStyle: const [0, 0, 0, 1],
          onclick: callback,
        )
      ],
    );
  }
}
