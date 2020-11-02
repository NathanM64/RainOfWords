import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/services.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';
import 'package:rainofwords/components/rain.dart';

class BtnGame {
  final GameController game;
  Rain rain;
  Rect rect;
  Sprite sprite;
  TextConfig titlePause = TextConfig(
      fontSize: 40,
      fontFamily: 'Chlakh',
      textAlign: TextAlign.center,
      color: Color(0xFF0D1D3E));

  BtnGame(this.game) {
    resize();
    sprite = Sprite('word_bg.png');
  }

  void render(Canvas c) {
    // c.drawRect(rect, btnPaint);
    sprite.renderRect(c, rect);
    titlePause.render(
        c,
        "Continuer",
        Position(
          game.tileSize * 3,
          (game.screenSize.height * 0.98) - (game.tileSize * 10),
        ));
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(game.tileSize * 1, game.tileSize * 5.8,
        game.tileSize * 8, game.tileSize * 4.5);
  }

  void onTapDown() {
    game.activeView = View.playing;
    if (game.runOnCreation == false) {
      game.resumeEngine();
      print('Play');
      game.runOnCreation = true;
    }
  }
}
