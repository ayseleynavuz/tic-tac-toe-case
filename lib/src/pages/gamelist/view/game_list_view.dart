import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/src/core/exports/constants_exports.dart';
import 'package:tic_tac_toe/src/core/services/firebase/game_service.dart';
import 'package:tic_tac_toe/src/core/services/local/local_service.dart';
import 'package:tic_tac_toe/src/core/services/navigation/navigation_service.dart';
import 'package:tic_tac_toe/src/pages/creategame/viewmodel/create_game_view_model.dart';
import 'package:tic_tac_toe/src/pages/creategame/widget/app_button.dart';

import '../../../common/model/game_model.dart';

class GameListView extends StatefulWidget {
  const GameListView({super.key});

  @override
  State<GameListView> createState() => _GameListViewState();
}

class _GameListViewState extends State<GameListView> {
  @override
  void initState() {
    super.initState();
    LocalCaching.instance.incrementAppCount();
  }

  @override
  Widget build(BuildContext context) {
    final CreateGameViewModel createGameViewModel =
        context.watch<CreateGameViewModel>();
    return Scaffold(
      body: Column(
        children: [
          60.verticalSpace,
          Text(
            "Game List",
            style: TextStyleConstants.mediumStyle(
              fontSize: 24.sp,
            ),
          ),
          60.verticalSpace,
          Expanded(
            child: StreamBuilder(
              stream: GameService.instance.getGames(),
              builder: (context, AsyncSnapshot<List<GameModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator.adaptive();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something wrong",
                        style: TextStyleConstants.mediumStyle(
                          color: ColorConstants.black,
                        )),
                  );
                }
                if (snapshot.hasData && (snapshot.data?.isNotEmpty ?? false)) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final GameModel currentGame = snapshot.data![index];
                        return ListTile(
                          title: Text(
                            currentGame.roomName,
                            style: TextStyleConstants.mediumStyle(
                              color: ColorConstants.black,
                            ),
                          ),
                          trailing: AppButton(
                            color: currentGame.gameStatus == GameStatus.waiting
                                ? ColorConstants.green
                                : ColorConstants.lightGreyColor,
                            buttonText: "Join",
                            onPressed: () => createGameViewModel.joinRoom(currentGame),
                          ),
                        );
                      });
                }
                return Center(
                  child: Text(
                    "Henüz Hiç Oyun Eklenmedi!",
                    style: TextStyleConstants.mediumStyle(
                      fontSize: 24.sp,
                      color: ColorConstants.black,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.instance.navigateToPage(
            path: NavigationConstants.createGameView,
          );
        },
        backgroundColor: ColorConstants.darkPurpleColor,
        child: const Icon(
          Icons.add,
          color: ColorConstants.lightPinkColor,
        ),
      ),
    );
  }
}
