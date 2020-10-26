import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';

class StartButton {
  final GameController game;
  Rect rect;
  Sprite sprite;
  TextConfig titleHome = TextConfig(
      color: Color(0xFF0D1D3E), fontSize: 45.0, fontFamily: 'Chlakh');

  StartButton(this.game) {
    resize();
    sprite = Sprite(
      'word_bg.png',
    );
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    titleHome.render(
        c,
        "Jouer",
        Position(
          game.tileSize * 3.5,
          (game.screenSize.height * 0.67) - (game.tileSize * 1.5),
        ));
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
        game.tileSize * 1,
        (game.screenSize.height * .60) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 4);
  }

  void onTapDown() {
    game.activeView = View.level;
    print('Bien joué');
  }
}
