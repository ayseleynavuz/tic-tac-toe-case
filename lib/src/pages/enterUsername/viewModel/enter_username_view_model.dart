import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tic_tac_toe/src/core/constants/colors/color_constants.dart';
import 'package:tic_tac_toe/src/core/constants/navigation/navigation_constants.dart';
import 'package:tic_tac_toe/src/core/mixins/show_bar.dart';
import 'package:tic_tac_toe/src/core/services/firebase/user_service.dart';
import 'package:tic_tac_toe/src/core/services/navigation/navigation_service.dart';

class EnterUsernameViewModel extends ChangeNotifier with ShowBar {
  TextEditingController usernameController = TextEditingController();

  void nextPage() {
    final String username = usernameController.text.trim();
    if (username.isEmpty) return;
    _saveUsername(username);
  }

  void _saveUsername(String userName) async {
    EasyLoading.show();
    final bool isAdded = await UserService.instance.saveUsername(userName);
    EasyLoading.dismiss();

    if (isAdded) {
      // navigate to next page
      NavigationService.instance
          .navigateToPage(path: NavigationConstants.gameListView);
    } else {
      // show error
      showErrorBar(
        "An error occurred while saving the username",
        backgroundColor: ColorConstants.red,
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }
}
