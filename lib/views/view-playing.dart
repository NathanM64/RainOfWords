import 'package:flame/sprite.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class PlayingView {
  final GameController game;
  Rect homeRect;
  Sprite homeSprite;

  PlayingView(this.game) {
    resize();
    homeSprite = Sprite('Backg/blue_mountain.png');
  }

  void render(Canvas c) {
    homeSprite.renderRect(c, homeRect);
  }

  void update(double t) {}

  void resize() {
    homeRect =
        Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
  }
}
