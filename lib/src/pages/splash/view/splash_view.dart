import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/src/core/exports/constants_exports.dart';
import 'package:tic_tac_toe/src/pages/creategame/widget/app_button.dart';
import 'package:tic_tac_toe/src/pages/splash/viewModel/splash_view_model.dart';

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
              style: TextStyleConstants.extraBoldStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            50.verticalSpace,
            AppButton(
              onPressed: () => splashViewModel.nextPage(),
              buttonText: 'Başla',
            ),
          ],
        ),
      ),
    );
  }
}

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const TypewriterText({super.key, required this.text, required this.style});

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  final _typingDuration = const Duration(milliseconds: 50);
  late String _displayedText;

  @override
  void initState() {
    _displayedText = '';
    _animateText();
    super.initState();
  }

  void _animateText() async {
    for (var i = 0; i <= widget.text.length; i++) {
      await Future.delayed(_typingDuration);
      setState(() {
        _displayedText = widget.text.substring(0, i);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: widget.style,
    );
  }
}
