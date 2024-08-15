import 'package:provider/provider.dart';
import 'package:tic_tac_toe/src/pages/creategame/viewmodel/create_game_view_model.dart';
import 'package:tic_tac_toe/src/pages/enterUsername/viewModel/enter_username_view_model.dart';
import 'package:tic_tac_toe/src/pages/splash/viewModel/splash_view_model.dart';
import 'package:tic_tac_toe/src/pages/splash/viewModel/type_writer_view_model.dart';

import '../../../common/viewModels/theme_view_model.dart';

// Uygulamayla ilgili temel veriler
class AppConstants {
  static const appName = 'Tic Tac Toe';
  static const fontFamily = 'fontFamily';
  static const privacyLink = '{PRIVACY_LINK}';
  static const supportMail = '{SUPPORT_MAIL}';

  static final defaultProviders = [
    ChangeNotifierProvider<ThemeViewModel>(
      create: (context) => ThemeViewModel(),
    ),

    ChangeNotifierProvider<SplashViewModel>(
      create: (context) => SplashViewModel(),
    ),
    ChangeNotifierProvider<EnterUsernameViewModel>(
      create: (context) => EnterUsernameViewModel(),
    ),
    ChangeNotifierProvider<CreateGameViewModel>(
      create: (context) => CreateGameViewModel(),
    ),
    ChangeNotifierProvider<CreateGameViewModel>(
      create: (context) => CreateGameViewModel(),
    ),

        ChangeNotifierProvider<TypewriterViewModel>(
      create: (context) => TypewriterViewModel(),
    ),
  ];
}
