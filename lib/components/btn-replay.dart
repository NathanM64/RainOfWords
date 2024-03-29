import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';

class ReplayButton {
  final GameController game;
  Rect rect;
  Sprite sprite;
  TextConfig textConfig =
      TextConfig(color: Color(0xFF0D1D3E), fontSize: 50, fontFamily: 'Chlakh');

  ReplayButton(this.game) {
    resize();
    sprite = Sprite(
      'word_bg.png',
    );
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    textConfig.render(
        c,
        "Rejouer",
        Position(
          game.tileSize * 3,
          (game.screenSize.height * .835) - (game.tileSize * 1.75),
        ));
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
        game.tileSize * 1,
        (game.screenSize.height * .755) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 4);
  }

  void onTapDown() {
    game.activeView = View.playing;
    game.score = 0;
    game.speed = 0;
    game.lifes = 3;
    game.words.removeRange(0, game.words.length);
  }
}
