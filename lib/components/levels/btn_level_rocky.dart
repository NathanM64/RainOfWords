import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/widgets.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';

class BtnLevelRocky {
  final GameController game;
  Rect rect;
  Sprite sprite;
  TextConfig titleLevels = TextConfig(
    fontSize: 35,
    fontFamily: 'Chlakh',
    color: Color(0xffffcdd2),
    textAlign: TextAlign.center,
  );

  // Paint btnPaint;

  BtnLevelRocky(this.game) {
    resize();
    sprite = Sprite('4thLevelBackg.png');
    // btnPaint = Paint()..color = Color(0xff17555f);
  }

  void render(Canvas c) {
    // c.drawRect(rect, btnPaint);
    sprite.renderRect(c, rect);
    titleLevels.render(
        c,
        "Rocky Mountain",
        Position(
          game.tileSize * 2.5,
          (game.screenSize.height * 1.36) - (game.tileSize * 9),
        ));
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
        game.tileSize * 1.2,
        (game.screenSize.height * .89) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 2.5);
  }

  void onTapDown() {
    game.activeView = View.playing;
    game.onLevelRocky = true;
    game.score = 0;
    game.speed = 0;
    game.lifes = 3;
    game.words.removeRange(0, game.words.length);
  }
}
