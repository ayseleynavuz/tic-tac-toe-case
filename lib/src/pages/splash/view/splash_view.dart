import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/src/core/exports/constants_exports.dart';
import 'package:tic_tac_toe/src/pages/creategame/widget/app_button.dart';
import 'package:tic_tac_toe/src/pages/splash/viewModel/splash_view_model.dart';

import '../../creategame/widget/type_writer_text.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashViewModel splashViewModel = context.read<SplashViewModel>();
    return Scaffold(
      backgroundColor: ColorConstants.textInfoColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TypewriterText(
              text: 'Tic Tac Toe\'ya Hoşgeldiniz!',
              shouldRepeat: false,
              style: TextStyleConstants.extraBoldStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            50.verticalSpace,
            AppButton(
              buttonText: 'Başla',
              onPressed: () => splashViewModel.nextPage(),
              color: ColorConstants.white,
            ),
          ],
        ),
      ),
    );
  }
}

