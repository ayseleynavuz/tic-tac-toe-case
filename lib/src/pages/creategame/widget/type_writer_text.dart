import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/src/core/constants/textStyles/text_style_constants.dart';

import '../../splash/viewModel/type_writer_view_model.dart';

class TypewriterText extends StatelessWidget {
  final String text;
  final bool shouldRepeat;
  final TextStyle? style;

  const TypewriterText({
    super.key,
    required this.text,
    this.shouldRepeat = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final typewriterViewModel = Provider.of<TypewriterViewModel>(context);

    // Start animation when text or shouldRepeat changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      typewriterViewModel.startAnimation(text, shouldRepeat: shouldRepeat);
    });

    return Selector<TypewriterViewModel, String>(
      selector: (context, viewModel) => viewModel.displayedText,
      builder: (context, displayedText, child) {
        return Text(
          displayedText,
          style: style ??  TextStyleConstants.extraBoldStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        );
      },
    );
  }
}
