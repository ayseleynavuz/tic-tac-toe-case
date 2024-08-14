import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tic_tac_toe/src/common/model/game_model.dart';
import 'package:tic_tac_toe/src/core/exports/constants_exports.dart';
import 'package:tic_tac_toe/src/core/mixins/show_bar.dart';
import 'package:tic_tac_toe/src/core/services/firebase/user_service.dart';
import 'package:tic_tac_toe/src/core/services/navigation/navigation_service.dart';

import '../../../core/services/firebase/game_service.dart';

class CreateGameViewModel extends ChangeNotifier with ShowBar {
  TextEditingController roomNameController = TextEditingController();
  String? selectedBoardBGColor;
  String? selectedBoxValue;

  void createGameRoom() async {
    if (roomNameController.text.isEmpty) {
      showErrorBar("Oyun Adı Boş Olamaz"); //TODO: Change message
      return;
    }
    EasyLoading.show();

    GameModel gameModel = GameModel(
      roomId: DateTime.now().millisecondsSinceEpoch.toString(),
      turnUserName: UserService.instance.username ?? "Player1",
      roomName: roomNameController.text,
      player1Name: UserService.instance.username ?? "Player1",
      player2Name: "",
      winnerPlayerName: "",
      board: [
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
      ],
      boardBackgroundColor: BoardGameColors.values
          .firstWhere(
            (element) => element.name == selectedBoardBGColor,
          )
          .color,
      gameStatus: GameStatus.waiting,
    );

    String? roomId = await GameService.instance.createGame(gameModel);
    EasyLoading.dismiss();

    if (roomId == null) {
      //SnackBar(content: content);
      return;
    }
    NavigationService.instance.navigateToPage(
      path: NavigationConstants.waitingOtherUsersView,
      data: roomId,
    );
  }

  void changeSelectedColor(String value) {
    selectedBoardBGColor = value;
    notifyListeners();
  }

  void changeSelectedBoxValue(String value) {
    selectedBoxValue = value;
    notifyListeners();
  }

  void cancelGame(String roomId) async {
    EasyLoading.show();
    final bool isCanceled = await GameService.instance.cancelGame(roomId);
    EasyLoading.dismiss();

    if (isCanceled) {
      showSuccessBar("Oyun İptal Edildi");
    } else {
      showErrorBar("Oyun İptal Edilemedi Lütfen Tekrar Deneyin");
      return;
    }

    NavigationService.instance.navigateToPage(
      path: NavigationConstants.gameListView,
    );
  }

  Future<void> joinRoom(GameModel currentGame) async {
    if (currentGame.gameStatus != GameStatus.waiting) {
      return;
    }

    EasyLoading.show();
    final bool isJoined =
        await GameService.instance.joinGame(currentGame.roomId);
    EasyLoading.dismiss();
    if (isJoined) {
      NavigationService.instance.navigateToPage(
        path: NavigationConstants.gameBoardView,
        data: currentGame.copyWith(
          gameStatus: GameStatus.startedGame,
          player2Name: UserService.instance.username ?? "Player 2",
        ),
      );
    } else {
      showErrorBar("Oyuna katılamadınız. Lütfen tekrar deneyin");
    }
  }
}

enum BoardGameColors {
  black(ColorConstants.black),
  white(ColorConstants.white),
  lightGrey(ColorConstants.lightGreyColor);

  final Color color;
  const BoardGameColors(this.color);
}
