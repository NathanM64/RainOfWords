import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';
import 'package:rainofwords/components/rain.dart';

class BtnPause {
  final GameController game;
  Rain rain;
  Rect rect;
  Sprite sprite;

  BtnPause(this.game) {
    resize();
    sprite = Sprite('iconPause.png');
  }

  void render(Canvas c) {
    // c.drawRect(rect, btnPaint);
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(game.tileSize * 9, game.tileSize * 0.5,
        game.tileSize * 0.6, game.tileSize * 0.6);
  }

  void onTapDown() {
    game.activeView = View.playing;
    if (game.runOnCreation == true) {
      print('Pause');
      game.runOnCreation = false;
    }
    // else {
    //   game.resumeEngine();
    //   print('Play');
    //   game.runOnCreation = true;
    // }
  }
}
