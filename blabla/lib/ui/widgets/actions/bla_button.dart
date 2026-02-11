import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

enum ColorButton { primary, secondary }

class BlaButton extends StatelessWidget {
  final ColorButton color;
  final VoidCallback onTap;
  final IconData? icon;
  final String title;
  const BlaButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.title, 
    this.icon,
  });


  Color get backgroundColor =>
      color == ColorButton.primary ? BlaColors.primary : BlaColors.white;
  Color get textColor =>
      color == ColorButton.primary ? BlaColors.white : BlaColors.primary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon),
              Text(title, style: TextStyle(fontSize: 24, color: textColor)),
            ],
          )
        ),
      ),
    );
  }
}
