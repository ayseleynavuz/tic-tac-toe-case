import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/src/core/constants/colors/color_constants.dart';
import 'package:tic_tac_toe/src/core/constants/textStyles/text_style_constants.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    this.buttonText, this.color,
  });

  final void Function()? onPressed;
  final String? buttonText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? ColorConstants.primaryColorLight.withOpacity(0.6),
      //disabledColor: ColorConstants.primaryColorLight.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        buttonText ?? 'Start Game', // local key in here
        style: TextStyleConstants.boldStyle(
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}
