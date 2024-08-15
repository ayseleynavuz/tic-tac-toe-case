import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/exports/constants_exports.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.items,
    this.text,
    this.onChanged,
  });

  final List<dynamic>? items;
  final String? text;
  final Function(Object?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return items?.isEmpty ?? true
        ? const SizedBox.shrink()
        : Container(
            height: 55.h,
            width: 300.w,
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.black50Color,
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              borderRadius: BorderRadius.circular(16.0.r),
              dropdownColor: ColorConstants.white,
              style: TextStyleConstants.mediumStyle(
                color: ColorConstants.black,
                fontSize: 12.sp,
              ),

              hint: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    5.horizontalSpace,
                    Text(
                      text ?? "",
                      style: TextStyleConstants.regularStyle(
                        color: ColorConstants.lightGreyColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.white,
                size: 22,
              ),

              //value: "data0",
              items: items
                  ?.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorConstants.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          );
  }
}
