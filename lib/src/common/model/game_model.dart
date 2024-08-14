import 'dart:ui';

class GameModel {
  final String roomId;
  final String roomName;
  final String player1Name;
  final String player2Name;
  final String winnerPlayerName;
  final List<String> board;
  final Color boardBackgroundColor;
  final GameStatus gameStatus;
  final String turnUserName;
  GameModel( {
    required this.roomId,
    required this.roomName,
    required this.player1Name,
    required this.player2Name,
    required this.winnerPlayerName,
    required this.board,
    required this.boardBackgroundColor,
    required this.gameStatus,
    required this.turnUserName,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      roomId: json['roomId'],
      roomName: json['roomName'],
      player1Name: json['player1Name'],
      player2Name: json['player2Name'],
      winnerPlayerName: json['winnerPlayerName'],
      board: List<String>.from(json['board']),
      boardBackgroundColor: Color(json['boardBackgroundColor']),
      gameStatus: GameStatus.values
          .firstWhere((element) => element.name == json['gameStatus']),

    turnUserName: json['turnUserName'] ?? "Player1",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'player1Name': player1Name,
      'player2Name': player2Name,
      'winnerPlayerName': winnerPlayerName,
      'board': board,
      'boardBackgroundColor': boardBackgroundColor.value,
      'gameStatus': gameStatus.name,
      'turnUserName': turnUserName, 
    };
  }

  GameModel copyWith({
    String? roomId,
    String? roomName,
    String? player1Name,
    String? player2Name,
    bool? isFinishedGame,
    String? winnerPlayerName,
    List<String>? board,
    Color? boardBackgroundColor,
    GameStatus? gameStatus,
    String? turnUserName,
  }) {
    return GameModel(
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      player1Name: player1Name ?? this.player1Name,
      player2Name: player2Name ?? this.player2Name,
      winnerPlayerName: winnerPlayerName ?? this.winnerPlayerName,
      board: board ?? this.board,
      boardBackgroundColor: boardBackgroundColor ?? this.boardBackgroundColor,
      gameStatus: gameStatus ?? this.gameStatus,
      turnUserName: turnUserName ?? this.turnUserName,
    );
  }
}

enum GameStatus { waiting, startedGame, finishedGame }
