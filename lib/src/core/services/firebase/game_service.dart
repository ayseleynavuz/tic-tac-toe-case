import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/src/common/model/game_model.dart';
import 'package:tic_tac_toe/src/core/services/firebase/user_service.dart';

class GameService {
  static final GameService _instance = GameService._init();

  static GameService get instance => _instance;
  GameService._init();

  final String _gameCollection = 'games';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createGame(GameModel game) async {
    try {
   
          await _firestore.collection(_gameCollection).doc(game.roomId).set(game.toJson());

      return game.roomId;
    } catch (e) {
      log("Error : $e");
    }
    return null;
  }

  Future<void> updateGame(GameModel game) async {
    try {
      await _firestore
          .collection(_gameCollection)
          .doc(game.roomId)
          .update(game.toJson());
    } catch (e) {
      log("Error : $e");
    }
  }

  // Future<void> deleteGame(String id) async {
  //   try {
  //     await _firestore.collection(_gameCollection).doc(id).delete();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Stream<List<GameModel>> getGames() {
    return _firestore.collection(_gameCollection).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => GameModel.fromJson(doc.data())).toList());
  }

  Stream<GameModel> getGame(String id) {
    return _firestore
        .collection(_gameCollection)
        .doc(id)
        .snapshots()
        .map((doc) => GameModel.fromJson(doc.data()!));
  }

  Future<void> addPlayer(String gameId, String playerId) async {
    try {
      await _firestore.collection(_gameCollection).doc(gameId).update({
        'players': FieldValue.arrayUnion([playerId])
      });
    } catch (e) {
      log("Error : $e");
    }
  }

  Future<void> removePlayer(String gameId, String playerId) async {
    try {
      await _firestore.collection(_gameCollection).doc(gameId).update({
        'players': FieldValue.arrayRemove([playerId])
      });
    } catch (e) {
      log("Error : $e");
    }
  }

  Future<bool> cancelGame(String roomId) async {
    try {
      await _firestore.collection(_gameCollection).doc(roomId).delete();
      return true;
    } catch (e) {
      log("Error : $e");
      return false;
    }
  }

  Future<bool> joinGame(String roomId) async {

    try {
      await _firestore.collection(_gameCollection).doc(roomId).update({
        'gameStatus': GameStatus.startedGame.name,
        'player2Name': UserService.instance.username ?? "Player 2",
      });
      return true;
    } catch (e) {
      log("Error : $e");
      return false;
    }
  }
}
