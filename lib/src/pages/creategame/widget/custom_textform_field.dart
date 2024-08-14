import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors/color_constants.dart';
import '../../../core/constants/textStyles/text_style_constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.onTap, this.controller,
  });

  final String? labelText;
  final String? hintText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black50Color,
            offset: const Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            onTap: onTap,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: ColorConstants.lightGreyColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorConstants.lightGreyColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: const BorderSide(
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),
            // içerideki input stili
            style: TextStyleConstants.regularStyle(
              color: ColorConstants.black,
            ),
          ),
        ],
      ),
    );
  }
}
