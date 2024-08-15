import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/core/constants/textStyles/text_style_constants.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final bool shouldRepeat; // Yeni bool parametre

  const TypewriterText({
    super.key,
    required this.text,
    this.shouldRepeat = false, // Varsayılan olarak false
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  final _typingDuration = const Duration(milliseconds: 100);
  final _deletingDuration = const Duration(milliseconds: 50);
  late String _displayedText;
  late String _incomingText;
  late String _outgoingText;
  final bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _incomingText = widget.text;
    _outgoingText = '';
    _displayedText = '';
    if (widget.shouldRepeat) {
      animateText();
    } else {
      animateTextOneTime();
    }
  }

  void animateText() async {
    while (widget.shouldRepeat) {
      final backwardLength = _outgoingText.length;
      if (backwardLength > 0) {
        for (var i = backwardLength; i >= 0; i--) {
          await Future.delayed(_deletingDuration);
          _displayedText = _outgoingText.substring(0, i);
          setState(() {});
        }
      }
      final forwardLength = _incomingText.length;
      if (forwardLength > 0) {
        for (var i = 0; i <= forwardLength; i++) {
          await Future.delayed(_typingDuration);
          _displayedText = _incomingText.substring(0, i);
          setState(() {});
        }
      }
      // Metin döngüsünü başa al
      _outgoingText = _incomingText;
    }
  }

  void animateTextOneTime() async {
    final backwardLength = _outgoingText.length;
    if (backwardLength > 0) {
      for (var i = backwardLength; i >= 0; i--) {
        await Future.delayed(_deletingDuration);
        _displayedText = _outgoingText.substring(0, i);
        setState(() {});
      }
    }
    final forwardLength = _incomingText.length;
    if (forwardLength > 0) {
      for (var i = 0; i <= forwardLength; i++) {
        await Future.delayed(_typingDuration);
        _displayedText = _incomingText.substring(0, i);
        setState(() {});
      }
    }
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    if (oldWidget.text != widget.text) {
      _outgoingText = oldWidget.text;
      _incomingText = widget.text;
      if (widget.shouldRepeat) {
        animateText();
      } else {
        animateTextOneTime();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: TextStyleConstants.extraBoldStyle(
        color: Colors.black,
        fontSize: 30,
      ),
    );
  }
}
