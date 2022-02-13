import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_calculator/widgets/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    setWindowMaxSize(const Size(1024, 768));
    setWindowMinSize(const Size(512, 384));
  }
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Calculator',
        theme: ThemeData(primaryColor: Colors.blue),
        home: Scaffold(
          body: SimpleCalculator(),
        ));
  }
}

class SimpleCalculator extends StatefulWidget {
  SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

String? operator;
int? result;
int? firstOperand;
int? secondOperand;

class _SimpleCalculatorState extends State<SimpleCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          ResultDisplay(text: _getDisplayText(), fontSize: 48.0),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      BuildButton(
                          buttonText: "C",
                          buttonHeight: 1,
                          buttonColor: Colors.redAccent,
                          onTap: () => clear()),
                      BuildButton(
                          buttonText: "⌫",
                          buttonHeight: 1,
                          buttonColor: Colors.blue,
                          onTap: () => delete()),
                      BuildButton(
                          buttonText: "÷",
                          buttonHeight: 1,
                          buttonColor: Colors.blue,
                          onTap: () => operatorPressed("÷")),
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "7",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(7)),
                      BuildButton(
                          buttonText: "8",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(8)),
                      BuildButton(
                          buttonText: "9",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(9)),
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "4",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(4)),
                      BuildButton(
                          buttonText: "5",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(5)),
                      BuildButton(
                          buttonText: "6",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(6)),
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "1",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(1)),
                      BuildButton(
                          buttonText: "2",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(2)),
                      BuildButton(
                          buttonText: "3",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(3)),
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: ".",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => operatorPressed(".")),
                      BuildButton(
                          buttonText: "0",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => numberPressed(0)),
                      BuildButton(
                          buttonText: "+/-",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => inverter()),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      BuildButton(
                          buttonText: "×",
                          buttonHeight: 1,
                          buttonColor: Colors.blue,
                          onTap: () => operatorPressed("×"))
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "-",
                          buttonHeight: 1,
                          buttonColor: Colors.blue,
                          onTap: () => operatorPressed("-"))
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "+",
                          buttonHeight: 1,
                          buttonColor: Colors.blue,
                          onTap: () => operatorPressed("+"))
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "=",
                          buttonHeight: 2,
                          buttonColor: Colors.redAccent,
                          onTap: () => calculateResult())
                    ])
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  inverter() {
    setState(() {
      if (result != null) {
        result == null;
        firstOperand = (firstOperand! * -1);
      }
    });
  }

  operatorPressed(String operatorValue) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      operator = operatorValue;
    });
  }

  numberPressed(int number) {
    setState(() {
      if (result != null) {
        result = null;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }

      secondOperand = int.parse('$secondOperand$number');
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          result = (firstOperand! + secondOperand!);
          break;
        case '-':
          result = firstOperand! - secondOperand!;
          break;
        case '×':
          result = firstOperand! * secondOperand!;
          break;
        case '÷':
          if (secondOperand == 0) {
            return;
          }
          result = (firstOperand! ~/ secondOperand!);
          break;
      }
      firstOperand = result;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  clear() {
    setState(() {
      result = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  delete() {}
  String _getDisplayText() {
    if (result != null) {
      return '$result';
    }
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    if (operator != null) {
      return '$firstOperand$operator';
    }
    if (firstOperand != null) {
      return '$firstOperand';
    }
    return '0';
  }
}
