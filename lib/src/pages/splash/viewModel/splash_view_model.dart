import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/src/core/constants/navigation/navigation_constants.dart';
import 'package:tic_tac_toe/src/core/services/local/local_service.dart';
import 'package:tic_tac_toe/src/core/services/navigation/navigation_service.dart';

class SplashViewModel extends ChangeNotifier {
  void nextPage() {
    final bool isFirstOpen = LocalCaching.instance.isFirstOpen;

    NavigationService.instance.navigateToPage(
      path: isFirstOpen
          ? NavigationConstants.enterUsernameView
          : NavigationConstants.gameListView,
    );
  }
}
