import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const CalculatorApp());
}

//=======================================================================================================================================================================================
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Simple Calculator',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          colorScheme: ThemeData.dark(useMaterial3: true).colorScheme,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //vars here

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _ScalingBox(),
    );
  }
}

class _ScalingBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double logicWidth = 600;
    double logicHeight = 700;
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fill,
        alignment: Alignment.center,
        child: SizedBox(
          width: logicWidth,
          height: logicHeight,
          child: const ScaffoldContent(),
        ),
      ),
    );
  }
}

class ScaffoldContent extends StatelessWidget {
  const ScaffoldContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Function calkeyOnClick = appState.pressedKeypad;

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "My Simple Calculator",
          ),
        ),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextDisplayContainer(
            inputText: appState.history,
            textType: 1,
          ),
          TextDisplayContainer(
            inputText: appState.textDisp,
            textType: 2,
          ),
          TextDisplayContainer(
            inputText: appState.shortDisplay,
            textType: 3,
          ),
          const SizedBox(height: 10),
          CalcKeys(
            callback: calkeyOnClick,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

//=======================================================================================================================================================================================
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

//=======================================================================================================================================================================================

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

//=======================================================================================================================================================================================
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

//=======================================================================================================================================================================================
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

//=======================================================================================================================================================================================
//=======================================================================================================================================================================================
//=======================================================================================================================================================================================
class MyAppState extends ChangeNotifier {
  num? num1;
  num? num2;
  String operand = '';

  num res = 0;
  num? prevRes;

  String history = '';
  String tempHistory = 'tempHistory';
  String textDisp = '0';
  String decDisp = '0';
  String shortDisplay = '0';
  bool dispRes = false;

  NumberFormat _numFormat = NumberFormat("0.0########E0##", 'en_us');

  //=================================================================
  //======================== UPDATE FORMAT ==========================
  //=================================================================

  NumberFormat updateFormat(num num, [int maxDigits = 9, int minDigits = -1]) {
    //max num = 999e+395
    // NumberFormat decFormat = NumberFormat("########0.########", 'en_us');
    NumberFormat decFormat = NumberFormat.decimalPattern('en_us');
    NumberFormat sciFormat = NumberFormat.scientificPattern('en_us');
    NumberFormat numberFormat; // OUTPUT
    // HANDLE EXCEPTIONS
    if (maxDigits > 12 ||
        maxDigits < 5 ||
        maxDigits.isInfinite ||
        maxDigits.isNaN) {
      // When manually changing maxDigits in function call
      throw Exception('Invalid maxDigits... must be 5 <= maxDigits <= 12');
    } else if (maxDigits.isInfinite || maxDigits.isNaN) {
      // When manually changing maxDigits in function call
      throw Exception('Invalid minDigits... must be 5 <= maxDigits <= 12');
    }
    // ADJUST IMPUTS
    if (minDigits > maxDigits) {
      minDigits = maxDigits;
    }
    // To scrutinize
    String numStr = num.toString();
    String digits = numStr.replaceAll(RegExp(r'[^0-9e]'), '');
    String decDigits = numStr.replaceAll(RegExp(r'[^.e0-9]'), '');
    // Important for output
    String format = '';
    int maxSigFigs;
    int minSigFigs;
    // For ease of logic
    int expIndex = -1;
    int decIndex = -1;
    // To simplify calculations
    int numIntDigits;
    int numDecDigits;
    int numExpDigits;

    if (numStr.contains('e')) {
      expIndex = decDigits.indexOf('e');
    }
    if (numStr.contains('.')) {
      decIndex = decDigits.indexOf('.');
    }

    if ((!num.isNegative && num.roundToDouble() <= 999999999) ||
        (num.isNegative && num.roundToDouble() >= -999999999)) {
      if (digits.length <= maxDigits && expIndex < 0) {
        // show as decimal form
        format = 'dec';
        maxSigFigs = digits.length;
      } else {
        if (expIndex < 0) {
          // we don't have an exp
          if (decIndex < 0) {
            // we don't have a decimal
            numIntDigits = digits.length;
            if (numIntDigits <= maxDigits) {
              // (Only intergers) If int-digits <= max-num-digits
              // USE DECIMAL FORMAT
              format = 'dec';
              maxSigFigs = numIntDigits;
            } else {
              // USE SCIENTIFIC FORMAT
              format = 'sci';
              maxSigFigs = maxDigits - (numIntDigits - maxDigits);
            }
          } else {
            // we have a decimal but no exponent
            numIntDigits = decDigits.split('.')[0].length;
            if (numIntDigits <= maxDigits) {
              // If number of int-digits <= max-num-digits
              if (decDigits[0] != '0') {
                // If the first int-digit is > 0
                // USE DECIMAL FORMAT
                format = 'dec';
                numDecDigits = decDigits.split('.')[1].length;
                if ((numIntDigits + numDecDigits) <= maxDigits) {
                  maxSigFigs = numIntDigits + numDecDigits;
                } else {
                  maxSigFigs = maxDigits;
                }
              } else {
                // When the first int-digit == 0, we need to check
                // how many 0's before the first non-zero value (significant)
                /// debugPrint('scrutinize: ${digits.indexOf(RegExp('r[^0]'))}');
                if (digits.indexOf(RegExp('r[^0]')) <= maxDigits) {
                  // USE DECIMAL FORMAT when the first none-zero value
                  // is in a place <= max-num-digits to be shown
                  format = 'dec';
                  maxSigFigs = digits.indexOf(RegExp('r[^0]'));
                } else {
                  // too many decimal places and 0 is the only int
                  // USE SCIENTIFIC FORMAT
                  format = 'sci';
                  maxSigFigs = maxDigits;
                }
              }
            } else {
              // When interger portion of the decimal has more digits than allowed
              // USE SCIENTIFIC FORMAT
              format = 'sci';
              maxSigFigs = maxDigits;
            }
          }
        } else {
          // we have an exponent
          format = 'sci';
          // Adjust significant figures
          numExpDigits = digits.split('e')[1].length;
          if (digits.split('e')[0].length <= (maxDigits - numExpDigits)) {
            maxSigFigs = digits.split('e')[0].length;
          } else {
            maxSigFigs = maxDigits - numExpDigits;
          }
        }
      }
    } else {
      maxSigFigs = maxDigits;
      format = 'sci';
    }

    //=================================================
    //============= Edit Assigned Format ==============
    //=================================================

    if (format == 'sci') {
      numberFormat = sciFormat;
      numberFormat.significantDigitsInUse = true;
      numberFormat.maximumSignificantDigits = maxSigFigs;

      numStr = numberFormat.format(num);
      numExpDigits = numStr.split('E')[1].length;
      if (numStr.split('E')[0].length <= (maxDigits - numExpDigits)) {
        maxSigFigs = numStr.split('E')[0].length;
      } else {
        maxSigFigs = maxDigits - numExpDigits;
      }
      minSigFigs = maxSigFigs;
      numberFormat.maximumSignificantDigits = maxSigFigs;
      // numberFormat.minimumSignificantDigitsStrict = true;
      numberFormat.minimumSignificantDigits = minSigFigs;
    } else if (format == 'dec') {
      numStr = decFormat.format(num).replaceAll(RegExp(r'[^0-9]'), '');
      if (numStr.length > maxDigits) {
        numberFormat = sciFormat;
      } else {
        numberFormat = decFormat;
      }
      numberFormat.significantDigitsInUse = true;
      numberFormat.maximumSignificantDigits = maxSigFigs;

      //FIX ME PLEASE: attempting to mess with the minimum significat digits
      // produces unnecessary zeros

      // if (!minDigits.isNegative && num == 0) {
      //   minSigFigs = minDigits;
      // } else {
      //   minSigFigs = maxSigFigs;
      // }
      // // numberFormat.minimumSignificantDigitsStrict = true;
      // numberFormat.minimumSignificantDigits = minSigFigs;
    } else {
      throw Exception('Invalid format');
    }

    debugPrint('digits: $decDigits or ${digits.length} digits');
    debugPrint('format: $format with $maxSigFigs sig figs');

    //==============================================================
    // numberFormat.significantDigitsInUse = true;
    // numberFormat.maximumSignificantDigits = maxSigFigs;
    // numberFormat.minimumSignificantDigitsStrict = true; //issues
    // numberFormat.minimumSignificantDigits = minSigFigs; //issues
    //==============================================================

    /// USELESS VALUES
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
    num tempNum;

    //Handle errors first and foremost
    if (btn == 'reset') {
      debugPrint('resetting');
      history = '';
      textDisp = '0';

      shortDisplay = '0';
      decDisp = '0';
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
          prevRes = num.parse(tempDisp);
          textDisp = tempDisp;
          //FIX ME PLEASE: show correct format
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

    //================================================
    //===== DO THIS TO NEVER SHOW ERRORS TO USER =====
    //================================================
    try {
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
            decDisp = '0';
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
              decDisp = '0';
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
              decDisp = '0';
              dispRes = false;
            } else if (textDisp.isEmpty || textDisp == '0') {
              // Don't delete if textDisp is empty
              break;
            } else {
              // Delete last char from textDisp
              textDisp = textDisp.substring(0, textDisp.length - 1);
              //FIX ME PLEASE: This short display should be formatted
              if (textDisp.isNotEmpty) {
                tempNum = num.parse(textDisp);
              } else {
                tempNum = 0;
              }
              _numFormat = updateFormat(
                tempNum, 9, //max digits
                textDisp.replaceAll(RegExp('[^0-9]'), '').length, //min digits
              );
              shortDisplay = _numFormat.format(tempNum);

              if (textDisp.isEmpty) {
                textDisp = '0';
                shortDisplay = '0';
                decDisp = '0';
              }
            }
          default:
            throw Exception('Special action is not registered.');
        }
      }
      //=================================================
      //================ OPERATION BTNS =================
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
              num2 = num.parse(textDisp);
            } else {
              if (num1 != null) {
                num2 = num.parse(textDisp);
              } else {
                num1 ??= num.parse(textDisp);
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
                decDisp = "ERROR";
                // drop flag after handling
                isError = false;
              } else {
                //FIX ME PLEASE: should only show 9 digits
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
        //=================================================
        //================= INPUT NUMBERS =================
        //=================================================
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
            if (dispRes) {
              // finished display results, edit new num
              dispRes = false;
              textDisp = '0';
            }
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
        //FIX ME PLEASE: make input a minimumNumber of digits
        /// Limit: 2^(63) -> num.parse(is the limiter);
        tempNum = num.parse(textDisp);
        _numFormat = updateFormat(
          tempNum,
          9, //max digits
          textDisp.replaceAll(RegExp('[^0-9]'), '').length, //min digits
        );
        shortDisplay = _numFormat.format(tempNum);
      } // end of if-elseif-else statements
    } catch (e) {
      debugPrint('e: $e');

      pressedKeypad('reset');
      textDisp = 'ERROR';
      shortDisplay = textDisp;
      dispRes = true; // bc we are showing error
    }
    notifyListeners();
  } // end of pressedKeypad();
}
