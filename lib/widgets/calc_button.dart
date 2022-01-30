import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  CalculatorButton({
    Key? key,
    required this.buttonText,
    required this.buttonHeight,
    required this.buttonColor,
  }) : super(key: key);

  final String buttonText;
  final double buttonHeight;
  final Color buttonColor;
  @override
  _CalculatorButtonState createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * widget.buttonHeight,
      color: widget.buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: null,
          child: Text(
            widget.buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }
}
