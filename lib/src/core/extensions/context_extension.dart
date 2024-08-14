import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// context ile her sayfa içerisinde kolayca erişmemizi sağlayan kısımlar

extension NavigationExtension on BuildContext {
  NavigatorState get rootNavigator => Navigator.of(this, rootNavigator: false);
  NavigatorState get navigator => Navigator.of(this);
}

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension PaddingExtensionSymetric on num {
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: h);

  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: w);

  EdgeInsets get allPadding => EdgeInsets.all(w);

  EdgeInsets get onlyLeftPadding => EdgeInsets.only(left: w);

  EdgeInsets get onlyRightPadding => EdgeInsets.only(right: w);

  EdgeInsets get onlyTopPadding => EdgeInsets.only(top: h);

  EdgeInsets get onlyBottomPadding => EdgeInsets.only(bottom: h);
}
