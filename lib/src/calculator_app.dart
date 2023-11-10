import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'appState/my_app_state_4.dart';
import 'widgets/keypad/calc_keys.dart';
import 'widgets/textDisplay/text_display_container.dart';

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
    return const SafeArea(
      child: ScaffoldContent(),
      //_ScalingBox(),
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
        fit: BoxFit.contain,
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
    double logicWidth = 450;
    double logicHeight = 600;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "My Simple Calculator",
            ),
          ),
          backgroundColor: theme.colorScheme.primaryContainer,
        ),
        body: Container(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 10),
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
            ),
          ),
        ),
      ),
    );
  }
}
