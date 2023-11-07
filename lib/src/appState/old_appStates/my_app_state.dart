import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyAppState extends ChangeNotifier {
  double? num1;
  double? num2;
  String operand = '';

  double res = 0;
  double? prevRes;

  String history = '';
  String tempHistory = 'tempHistory';
  String textDisp = '0';
  String shortDisplay = '0';
  bool dispRes = false;

  //FIXME: may need to fix format to my liking

  // final NumberFormat _numFormat = NumberFormat.decimalPattern('en_us');
  // final NumberFormat _sciFormat = NumberFormat.scientificPattern('en_us');
  NumberFormat _numFormat = NumberFormat("0.0########E0##", 'en_us');

  //=================================================================
  //======================== UPDATE FORMAT ==========================
  //=================================================================

  NumberFormat updateFormat(double num, [int maxDigits = 9]) {
    //max num = 999e+395
    // NumberFormat numberFormat =
    // NumberFormat("########0.0########E0##", 'en_us');
    // NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');
    NumberFormat numberFormat = NumberFormat.scientificPattern('en_us');

    //do a simple check of wether we can effect decimal patter;
    // hard code it

    numberFormat.significantDigitsInUse = true;
    numberFormat.maximumSignificantDigits = maxDigits;

    if (num.toString().contains('.')) {
      numberFormat.minimumSignificantDigitsStrict = true;
      if (num.toString().length < maxDigits) {
        // display small numbers (e.g. 0.001)
        var tempString = num.toString().replaceAll(RegExp(r'[^0-9]'), '');
        if (tempString.contains('e')) {
          numberFormat.minimumSignificantDigits =
              tempString.split('e')[0].length - 2;
        } else {
          numberFormat.minimumSignificantDigits = tempString.length - 2;
        }
      } else {
        numberFormat.minimumSignificantDigits = maxDigits;
      }
    } else {
      numberFormat.minimumSignificantDigitsStrict = false;
    }

    // numberFormat.maximumIntegerDigits = maxDigits;
    // numberFormat.maximumFractionDigits = maxDigits;
    // numberFormat.minimumExponentDigits = maxDigits;
    return numberFormat;
  }

  //=================================================================
  //======================= PRESSED KEYPAD ==========================
  //=================================================================

  void pressedKeypad(String btn) {
    // Necessary Vars
    bool isError = false;
    // Placeholder vars
    String tempString;
    String tempDisp;
    String tempBtn;
    double tempNum;

    //Handle errors first and foremost
    if (btn == 'reset') {
      debugPrint('resetting');
      history = '';
      textDisp = '0';
      shortDisplay = '0';
      dispRes = false;

      res = 0;
      prevRes = null;
      num1 = null;
      num2 = null;
      operand = '';

      return;
    } else if (textDisp == 'NaN' ||
        res.isNaN ||
        textDisp == 'Infinity' ||
        res.isInfinite) {
      // save important vals
      tempDisp = textDisp;
      tempBtn = btn;
      // Recursively reset myself
      pressedKeypad(btn = 'reset');
      // Re-assign valid values
      if (tempDisp.isNotEmpty &&
          (tempDisp != 'NaN' || tempDisp != 'Infinity')) {
        if (btn == '/' ||
            btn == 'x' ||
            btn == '–' ||
            btn == '+' ||
            btn == '=') {
          prevRes = double.parse(tempDisp);
          textDisp = tempDisp;
          //FIXME: show correct format
          _numFormat = updateFormat(prevRes!);
          shortDisplay = _numFormat.format(prevRes);

          dispRes = true; // bc we are showing new num
          if (btn != '=') {
            operand = tempBtn;
          }
        }
      }
      // remember btn
      btn = tempBtn;
    } // end of error checking

    //=================================================
    //============== SPECIAL ACTION BTNS ==============
    //=================================================
    if (btn == 'AC' || btn == 'C' || btn == 'Del') {
      // Special action buttons
      switch (btn) {
        case 'AC':
          debugPrint('sp: $btn');
          history = '';
          textDisp = '0';
          shortDisplay = '0';
          dispRes = false;

          res = 0;
          prevRes = null;
          num1 = null;
          num2 = null;
          operand = '';
        case 'C':
          debugPrint('sp: $btn');
          if (textDisp.isNotEmpty) {
            debugPrint('\tC: no num2');
            textDisp = '0';
            shortDisplay = '0';
            dispRes = false;
            res = 0;
          } else {
            debugPrint('\tC: nowAC');
            pressedKeypad(btn = 'AC');
          }
        case 'Del':
          debugPrint('sp: $btn');
          if (dispRes) {
            textDisp = '0';
            shortDisplay = '0';
            dispRes = false;
          } else if (textDisp.isEmpty || textDisp == '0') {
            // Don't delete if textDisp is empty
            break;
          } else {
            // Delete last char from textDisp
            textDisp = textDisp.substring(0, textDisp.length - 1);
            //FIXME: This short display should be formatted
            tempNum = double.parse(textDisp);
            _numFormat = updateFormat(tempNum);
            shortDisplay = _numFormat.format(tempNum);

            if (textDisp.isEmpty) {
              textDisp = '0';
              shortDisplay = '0';
            }
          }
        default:
          throw Exception('Special action is not registered.');
      }
    }
    //=================================================
    //============== OPERATION BTNS ==============
    //=================================================
    else if (btn == '/' ||
        btn == 'x' ||
        btn == '–' ||
        btn == '+' ||
        btn == '=') {
      debugPrint('op: $btn');

      if (textDisp.isEmpty) {
        return;
      } else {
        // if (btn != '=')
        if (dispRes) {
          if (btn != '=') {
            operand = btn;
            if (prevRes != null) {
              if (history.contains("(") == false) {
                tempHistory = history;
              }
              history = "($tempHistory) $operand";
            } else {
              if (history.isNotEmpty) {
                history =
                    "${history.substring(0, history.length - 2)} $operand";
              }
            }
          }
        } else {
          // assignig a new num so we displayed its result
          // then, we want a new num
          dispRes = true;
          if (prevRes != null) {
            num1 = prevRes;
            num2 = double.parse(textDisp);
          } else {
            if (num1 != null) {
              num2 = double.parse(textDisp);
            } else {
              num1 ??= double.parse(textDisp);
            }
          }

          if (num1 != null && num2 != null) {
            if (operand.isNotEmpty) {
              switch (operand) {
                case '/':
                  res = num1! / num2!;
                case 'x':
                  res = num1! * num2!;
                case '–':
                  res = num1! - num2!;
                case '+':
                  res = num1! + num2!;
                  // case '=':
                  break;
                default:
                  throw Exception('Invalid operation.');
              }
              tempHistory = "$num1 $operand $num2";
              if (btn != '=') {
                operand = btn;
                history = "($tempHistory) $operand";
              } else {
                history = tempHistory;
              }

              if (res.isInfinite || res.isNaN) {
                // Raise error flag for shortDisplay
                isError = true;
              }
            }

            dispRes = true;
            prevRes = res;
            textDisp = res.toString();
            num1 = null;
            num2 = null;
            if (isError) {
              _numFormat = updateFormat(res);
              shortDisplay = _numFormat.format(res);

              shortDisplay = "ERROR: $shortDisplay";
              // drop flag after handling
              isError = false;
            } else {
              //FIXME: should only show 9 digits
              _numFormat = updateFormat(res);
              shortDisplay = _numFormat.format(res);
            }
          } // end of if num1 or num2 are not null
          else {
            // save operand for next operation
            if (btn != '=') {
              operand = btn;
            }
          }

          // Update history
          if (num1 != null && num2 == null) {
            if (operand != '') {
              history = "$num1 $operand";
            } else if (btn != '=') {
              history = "$num1 $btn";
            }
          }
        }
      }
    } else {
      // handle numbers
      // account for (+/-) and (.)
      switch (btn) {
        case '+/-':
          debugPrint('numSy: $btn');
          if (dispRes) {
            // finished display results, edit new num
            dispRes = false;
          }
          if (textDisp == '0') {
            break;
          } else if (textDisp[0] != '-') {
            textDisp = "-$textDisp";
          } else {
            textDisp = textDisp.substring(1, textDisp.length);
          }
        case '.':
          debugPrint('numSy: $btn');
          if (textDisp.contains(".") == false) {
            textDisp = "$textDisp$btn";
          }
        default:
          // expect case'0-9'
          if (int.tryParse(btn) == null) {
            throw Exception(
                'Key input is not an interger or might not be registered.');
          } else {
            debugPrint('num: $btn');

            if (dispRes) {
              // finished display results, write new num
              dispRes = false;
              textDisp = '';
            }
            tempString = textDisp.replaceAll(RegExp('[^0-9]'), '');
            if (textDisp == '0') {
              textDisp = btn;
            } else if (tempString.length < 9) {
              // max user imput is 9
              textDisp = "$textDisp$btn";
            }
          }
      } // end of switch-case statements
      // Edit display right after adding/editing new digits
      //FIXME: show at most 9 digits when possible...
      /// Limit: 2^(63) -> double.parse(is the limiter);
      tempNum = double.parse(textDisp);
      _numFormat = updateFormat(tempNum);
      shortDisplay = _numFormat.format(tempNum);
    } // end of if-elseif-else statements
    notifyListeners();
  } // end of pressedKeypad();
}
