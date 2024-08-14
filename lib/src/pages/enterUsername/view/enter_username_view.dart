import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/src/core/constants/textStyles/text_style_constants.dart';
import 'package:tic_tac_toe/src/pages/creategame/widget/app_button.dart';
import 'package:tic_tac_toe/src/pages/creategame/widget/custom_textform_field.dart';
import 'package:tic_tac_toe/src/pages/enterUsername/viewModel/enter_username_view_model.dart';

class EnterUsernameView extends StatelessWidget {
  const EnterUsernameView({super.key});

  @override
  Widget build(BuildContext context) {
    final EnterUsernameViewModel enterUserNameViewModel =
        context.read<EnterUsernameViewModel>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hadi Seni Tanıyalım!",
              style: TextStyleConstants.mediumStyle(
                fontSize: 30.sp,
              ),
            ),
            60.verticalSpace,
            CustomTextFormField(
              controller: enterUserNameViewModel.usernameController,
              hintText: 'Enter your username',
            ),
            60.verticalSpace,
            AppButton(
              buttonText: "Start",
              onPressed: () =>
                  context.read<EnterUsernameViewModel>().nextPage(),
            ),
          ],
        ),
      ),
    );
  }
}
