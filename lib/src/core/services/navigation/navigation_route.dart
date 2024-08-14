import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/common/model/game_model.dart';
import 'package:tic_tac_toe/src/pages/creategame/view/create_game_view.dart';
import 'package:tic_tac_toe/src/pages/enterUsername/view/enter_username_view.dart';
import 'package:tic_tac_toe/src/pages/gameboard/view/game_board_view.dart';
import 'package:tic_tac_toe/src/pages/gamelist/view/game_list_view.dart';
import 'package:tic_tac_toe/src/pages/splash/view/splash_view.dart';
import 'package:tic_tac_toe/src/pages/waitingotherusers/view/waiting_other_users_view.dart';

import '../../exports/constants_exports.dart';

// Router yapılarının oluşturulduğu kısım
class NavigationRoute {
  NavigationRoute._init();

  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case NavigationConstants.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: RouteSettings(arguments: args),
        );
      case NavigationConstants.enterUsernameView:
        return MaterialPageRoute(
          builder: (context) => const EnterUsernameView(),
          settings: RouteSettings(arguments: args),
        );

      case NavigationConstants.createGameView:
        return MaterialPageRoute(
          builder: (context) => const CreateGameView(),
          settings: RouteSettings(arguments: args),
        );

      case NavigationConstants.gameListView:
        return MaterialPageRoute(
          builder: (context) => const GameListView(),
          settings: RouteSettings(arguments: args),
        );
      case NavigationConstants.gameBoardView:
        return MaterialPageRoute(
          builder: (context) =>  GameBoardView(
            gameModel: args as GameModel,
            
          ),
          settings: RouteSettings(arguments: args),
        );
      case NavigationConstants.waitingOtherUsersView:
        return MaterialPageRoute(
          builder: (context) => const WaitingOtherUsersView(),
          settings: RouteSettings(arguments: args),
        );
    }
    return null;
  }
}
