import 'package:flutter/material.dart';

class ColorConstants {
  static const black = Colors.black;
  static const white = Colors.white;
  static const red = Colors.red;
  static const green = Colors.green;

  static const Color primaryColor = Color(0xff433168);
  static const Color primaryColorLight = Color(0xffDD88CF);
  static const Color lightBgColor = Color(0xffF9FAFB);

  static const Color pinkColor = Color(0xffED499A);
  static const Color lightPinkColor = Color(0xffF8E7F6);
  static const Color orangeColor = Color(0xffED793C);
  static const Color yellowColor = Color(0xffF4C754);
  static const Color darkPurpleColor = Color(0xff320049);
  static const Color lightPurpleColor = Color(0xff7C6D99);
  static const Color searchIconColor = Color(0xff4B164C);
  static const Color searchBgColor = Color(0xffFDF7FD);
  static const Color logoutColor = Color(0xffFC6C6B);
  static Color black50Color =
      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5);

  static const Color lightGreyColor = Color(0xffB9B9B9);
  static const Color darkGreyColor = Color(0xff6D6D6D);
  static const Color textButtonColor = Color(0xffE2D3FF);
  static const Color textInfoColor = Color(0xff22172A);

  static LinearGradient buttonGradient = LinearGradient(
    colors: [
      const Color(0xff433168), // %100
      const Color(0xff443268).withOpacity(.74), // %74
    ],
    stops: const [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
