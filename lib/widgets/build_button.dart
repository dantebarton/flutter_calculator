import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  const BuildButton(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.buttonHeight,
      required this.onTap})
      : super(key: key);

  final String buttonText;
  final double buttonHeight;
  final Color buttonColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      padding: const EdgeInsets.all(1.0),
      child: Ink(
        color: buttonColor,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: const BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          onTap: onTap,
          child: Center(
              child: Text(
            buttonText,
            style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
        ),
      ),
    );
  }
}
