import 'package:flutter/material.dart';
import 'package:shoes/views/shared/appstyle.dart';

class CatagoryBtn extends StatelessWidget {
  const CatagoryBtn(
      {super.key, this.onPress, required this.buttonClr, required this.label});

  final void Function()? onPress;
  final Color buttonClr;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonClr,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(9)),
        ),
        child: Center(
          child: Text(
            label,
            style: appstyle(15, buttonClr, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
