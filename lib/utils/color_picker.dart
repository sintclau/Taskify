import 'package:flutter/material.dart';

class AppColors {
  static Color primaryBlue = const Color.fromARGB(255, 19, 146, 186);
  static Color secondaryBlue = const Color.fromARGB(255, 145, 209, 230);
  static Color primaryOrange = const Color.fromARGB(255, 255, 108, 68);
  static Color secondaryOrange = const Color.fromARGB(255, 230, 162, 145);
  static Color primaryPurple = const Color.fromARGB(255, 114, 66, 255);
  static Color secondaryPurple = const Color.fromARGB(255, 171, 145, 230);
  static Color primaryGreen = const Color.fromARGB(255, 13, 191, 19);
  static Color secondaryGreen = const Color.fromARGB(255, 151, 230, 145);
  static Color primaryRed = const Color.fromARGB(255, 233, 25, 25);
  static Color secondaryRed = const Color.fromARGB(255, 230, 145, 145);
}

class CustomColorPicker extends StatelessWidget {
  Color pickedColor;
  final Function(Color) onColorPicked;

  CustomColorPicker(this.pickedColor, this.onColorPicked);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            pickedColor = AppColors.primaryBlue;
            onColorPicked(pickedColor);
            print(pickedColor);
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: AppColors.primaryBlue,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            pickedColor = AppColors.primaryOrange;
            onColorPicked(pickedColor);
            print(pickedColor);
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: AppColors.primaryOrange,
            ),
          ),
        ),
      ],
    );
  }
}
