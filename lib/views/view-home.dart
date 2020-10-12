import 'package:flame/sprite.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomeView {
  final GameController game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    resize();
    titleSprite = Sprite('croped_Bg.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {}

  void resize() {
    titleRect =
        Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
  }
}
