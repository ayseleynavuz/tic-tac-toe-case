import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/src/common/model/game_model.dart';
import 'package:tic_tac_toe/src/core/exports/constants_exports.dart';
import 'package:tic_tac_toe/src/core/services/firebase/game_service.dart';
import 'package:tic_tac_toe/src/core/services/navigation/navigation_service.dart';
import 'package:tic_tac_toe/src/pages/creategame/viewmodel/create_game_view_model.dart';
import 'package:tic_tac_toe/src/pages/creategame/widget/app_button.dart';

import '../../creategame/widget/type_writer_text.dart';

class WaitingOtherUsersView extends StatefulWidget {
  const WaitingOtherUsersView({super.key});

  @override
  State<WaitingOtherUsersView> createState() => _WaitingOtherUsersViewState();
}

class _WaitingOtherUsersViewState extends State<WaitingOtherUsersView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        String roomId = ModalRoute.of(context)?.settings.arguments as String;
        GameService.instance.getGame(roomId).listen(
          (event) {
            if (event.gameStatus == GameStatus.startedGame) {
              NavigationService.instance.navigateToPage(
                path: NavigationConstants.gameBoardView,
                data: event,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CreateGameViewModel createGameViewModel =
        context.watch<CreateGameViewModel>();
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TypewriterText(
                text: "Waiting Other Users",
                shouldRepeat: true,
              ),
              AppButton(
                onPressed: () {
                  String roomId =
                      ModalRoute.of(context)?.settings.arguments as String;
                  createGameViewModel.cancelGame(roomId);
                },
                buttonText: "Cancel",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
