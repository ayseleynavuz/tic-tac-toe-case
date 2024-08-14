import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/src/common/model/game_model.dart';
import 'package:tic_tac_toe/src/core/constants/colors/color_constants.dart';
import 'package:tic_tac_toe/src/core/constants/textStyles/text_style_constants.dart';
import 'package:tic_tac_toe/src/core/services/firebase/game_service.dart';
import 'package:tic_tac_toe/src/core/services/firebase/user_service.dart';

class GameBoardView extends StatefulWidget {
  final GameModel gameModel;

  const GameBoardView({super.key, required this.gameModel});

  @override
  _GameBoardViewState createState() => _GameBoardViewState();
}

class _GameBoardViewState extends State<GameBoardView> {
  late List<List<String?>> _board;
  String? _winner;
  late GameModel _gameModel;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _gameModel = widget.gameModel;

    GameService.instance.getGame(_gameModel.roomId).listen((event) {
      if (event.gameStatus == GameStatus.startedGame) {
        setState(() {
          _gameModel = event;
        });
      }
    });
  }

  void _handleTap(int row, int col) async {
    if (_gameModel.turnUserName != UserService.instance.username) {
      return;
    }
    if (_board[row][col] == "" && _winner == null) {
      setState(() {
        _board[row][col] =
            _gameModel.turnUserName == _gameModel.player1Name ? 'X' : 'O';
        _checkWinner();
        GameModel updatedGameModel = _gameModel.copyWith(
          turnUserName: _gameModel.turnUserName == _gameModel.player1Name
              ? _gameModel.player2Name
              : _gameModel.player1Name,
          board: _board
              .expand((row) => row.map(
                    (e) => e!,
                  ))
              .toList(),
        );
        GameService.instance.updateGame(updatedGameModel);
      });
    }
  }

  void _checkWinner() {
    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] != "" &&
          _board[i][0] == _board[i][1] &&
          _board[i][0] == _board[i][2]) {
        setState(() {
          _winner = _board[i][0] == "O"
              ? _gameModel.player2Name
              : _gameModel.player1Name;
          _gameModel = _gameModel.copyWith(
            gameStatus: GameStatus.finishedGame,
            winnerPlayerName: _winner,
          );
          GameService.instance.updateGame(_gameModel);
        });
        return;
      }
      if (_board[0][i] != "" &&
          _board[0][i] == _board[1][i] &&
          _board[0][i] == _board[2][i]) {
        setState(() {
          _winner = _board[0][i] == "O"
              ? _gameModel.player2Name
              : _gameModel.player1Name;

          _gameModel = _gameModel.copyWith(
            gameStatus: GameStatus.finishedGame,
            winnerPlayerName: _winner,
          );
          GameService.instance.updateGame(_gameModel);
        });
        return;
      }
    }

    // Check diagonals
    if (_board[0][0] != "" &&
        _board[0][0] == _board[1][1] &&
        _board[0][0] == _board[2][2]) {
      setState(() {
        _winner = _board[0][0] == "O"
            ? _gameModel.player2Name
            : _gameModel.player1Name;
        _gameModel = _gameModel.copyWith(
          gameStatus: GameStatus.finishedGame,
          winnerPlayerName: _winner,
        );
        GameService.instance.updateGame(_gameModel);
      });
      return;
    }
    if (_board[0][2] != "" &&
        _board[0][2] == _board[1][1] &&
        _board[0][2] == _board[2][0]) {
      setState(() {
        _winner = _board[0][2] == "O"
            ? _gameModel.player2Name
            : _gameModel.player1Name;
        _gameModel = _gameModel.copyWith(
          gameStatus: GameStatus.finishedGame,
          winnerPlayerName: _winner,
        );
        GameService.instance.updateGame(_gameModel);
      });
      return;
    }

    // Check for draw
    bool draw = true;
    for (var row in _board) {
      if (row.contains("")) {
        draw = false;
        break;
      }
    }
    if (draw) {
      setState(() {
        _winner = 'Draw';
      });
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => null));

      _winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<GameModel>(
        stream: GameService.instance.getGame(_gameModel.roomId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Bir hata oluştu',
                style: TextStyleConstants.mediumStyle(
                  color: ColorConstants.black,
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            final GameModel currentGame = snapshot.data!;
            if (_board !=
                List.generate(
                    3,
                    (i) => currentGame.board
                        .sublist(i * 3, (i + 1) * 3)
                        .map((e) => e as String?)
                        .toList())) {
              _board = List.generate(
                3,
                (i) => currentGame.board
                    .sublist(i * 3, (i + 1) * 3)
                    .map((e) => e as String?)
                    .toList(),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                60.verticalSpace,
                Text(
                  currentGame.winnerPlayerName.isNotEmpty
                      ? (_winner == 'Draw'
                          ? 'Beraberlik!'
                          : 'Kazanan: ${currentGame.winnerPlayerName}')
                      : 'Sıra: ${currentGame.turnUserName}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 60.h),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 9,
                    padding: EdgeInsets.all(15.r),
                    itemBuilder: (context, index) {
                      final row = index ~/ 3;
                      final col = index % 3;
                      return GestureDetector(
                        onTap: () => _handleTap(row, col),
                        child: Container(
                          margin: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstants.primaryColor,
                            ),
                            color: currentGame.boardBackgroundColor,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: Text(
                              _board[row][col] ?? '',
                              style: TextStyleConstants.boldStyle(
                                color: ColorConstants.white,
                                fontSize: 48.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (_winner == 'Draw')
                  GestureDetector(
                    onTap: _resetGame,
                    child: Container(
                      width: 300.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        color: ColorConstants.lightBgColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.r),
                        ),
                        border: Border.all(
                          color: ColorConstants.darkGreyColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.restart_alt,
                          ),
                          SizedBox(width: 20.w),
                          Text(
                            'Yeniden Oyna',
                            style: TextStyleConstants.boldStyle(
                              color: ColorConstants.black,
                              fontSize: 24.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 25.h),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
