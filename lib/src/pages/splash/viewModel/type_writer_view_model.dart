import 'package:flutter/foundation.dart';

class TypewriterViewModel extends ChangeNotifier {
  String _displayedText = '';
  String _text = '';
  bool _isAnimating = false;

  String get displayedText => _displayedText;

  void startAnimation(String text, {bool shouldRepeat = false}) {
    if (_text != text) {
      _text = text;
      _displayedText = '';
      _isAnimating = true;
      notifyListeners();
      _animateText(shouldRepeat);
    }
  }

  void _animateText(bool shouldRepeat) async {
    const typingDuration = Duration(milliseconds: 100);
    const deletingDuration = Duration(milliseconds: 50);

    while (_isAnimating) {
      final backwardLength = _displayedText.length;
      if (backwardLength > 0) {
        for (var i = backwardLength; i >= 0; i--) {
          await Future.delayed(deletingDuration);
          _displayedText = _text.substring(0, i);
          notifyListeners();
        }
      }

      final forwardLength = _text.length;
      if (forwardLength > 0) {
        for (var i = 0; i <= forwardLength; i++) {
          await Future.delayed(typingDuration);
          _displayedText = _text.substring(0, i);
          notifyListeners();
        }
      }

      if (!shouldRepeat) {
        _isAnimating = false;
      }
    }
  }

  void stopAnimation() {
    _isAnimating = false;
  }
}
