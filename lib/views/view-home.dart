import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomeView {
  final GameController game;
  Rect homeRect;
  Sprite homeSprite;
  TextConfig titleHome = TextConfig(fontSize: 72, fontFamily: 'Awesome Font');

  HomeView(this.game) {
    resize();
    homeSprite = Sprite('Backg/home.png');
  }

  void render(Canvas c) {
    homeSprite.renderRect(c, homeRect);
    titleHome.render(
        c,
        "Rain\n  of\nWords",
        Position(
          game.tileSize * 2.5,
          (game.screenSize.height * 0.6) - (game.tileSize * 9),
        ));
  }

  void update(double t) {}

  void resize() {
    homeRect =
        Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
  }
}
