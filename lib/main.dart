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
        initialRoute: '/',
        routes: {
          '/': (context) => SimpleCalculator(),
          '/second': (context) => const CalcHistory()
        }
        // home: Scaffold(
        //   body: SimpleCalculator(),
        // )
        );
  }
}

class SimpleCalculator extends StatefulWidget {
  SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

String? operator;
String equation = "0";
int? result;
int? firstOperand;
int? secondOperand;
int? deleted;

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
                          onTap: () => _operatorPressed("÷")),
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "7",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(7)),
                      BuildButton(
                          buttonText: "8",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(8)),
                      BuildButton(
                          buttonText: "9",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(9)),
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "4",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(4)),
                      BuildButton(
                          buttonText: "5",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(5)),
                      BuildButton(
                          buttonText: "6",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(6)),
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "1",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(1)),
                      BuildButton(
                          buttonText: "2",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(2)),
                      BuildButton(
                          buttonText: "3",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(3)),
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "H",
                          buttonColor: Colors.redAccent,
                          buttonHeight: 1,
                          onTap: () {
                            Navigator.pushNamed(context, '/second');
                          }),
                      BuildButton(
                          buttonText: "0",
                          buttonHeight: 1,
                          buttonColor: Colors.black54,
                          onTap: () => _numberPressed(0)),
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
                          onTap: () => _operatorPressed("×"))
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "-",
                          buttonHeight: 1,
                          buttonColor: Colors.blue,
                          onTap: () => _operatorPressed("-"))
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "+",
                          buttonHeight: 1,
                          buttonColor: Colors.blue,
                          onTap: () => _operatorPressed("+"))
                    ]),
                    TableRow(children: [
                      BuildButton(
                          buttonText: "=",
                          buttonHeight: 2,
                          buttonColor: Colors.redAccent,
                          onTap: () => _calculateResult())
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
        return;
      }

      if (secondOperand != null) {
        secondOperand = (secondOperand! * -1);
        return;
      }

      if (firstOperand != null) {
        firstOperand = (firstOperand! * -1);
        return;
      }
    });
  }

  _operatorPressed(String operatorValue) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      operator = operatorValue;
    });
  }

  _numberPressed(int number) {
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

  _calculateResult() {
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

  delete() {
    setState(() {
      deleted = 1;
      equation = equation.substring(0, equation.length - 1);
      if (equation.isEmpty) {
        equation = '0';
      }
      if (secondOperand != null) {
        if (equation.substring(equation.indexOf(operator!) + 1).isEmpty) {
          secondOperand = null;
        } else {
          secondOperand =
              int.tryParse(equation.substring(equation.indexOf(operator!) + 1));
        }
        return;
      }
      if (operator != null) {
        operator = null;
        return;
      }
      if (firstOperand != null) {
        firstOperand = int.tryParse(equation);
        return;
      }
    });
  }

  String _getDisplayText() {
    if (deleted != null) {
      deleted = null;
      return equation;
    }
    if (result != null) {
      equation = '$result';
      return equation;
    }
    if (secondOperand != null) {
      equation = '$firstOperand$operator$secondOperand';
      return equation;
    }
    if (operator != null) {
      equation = '$firstOperand$operator';
      return equation;
    }
    if (firstOperand != null) {
      equation = '$firstOperand';
      return equation;
    }

    return equation = '0';
  }
}

class CalcHistory extends StatelessWidget {
  const CalcHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
        ));
  }
}
