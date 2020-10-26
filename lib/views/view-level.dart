import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flame_svg/flame_svg.dart';
import 'dart:ui';

class LevelView {
  final GameController game;
  Svg homeSvg;
  Rect homeRect;
  Paint bgPaint;
  TextConfig titleLevel = TextConfig(fontSize: 42, fontFamily: 'Chlakh');

  LevelView(this.game) {
    resize();
  }

  void render(Canvas c) {
    bgPaint = Paint();
    bgPaint.color = Color(0xffffffff);
    c.drawRect(homeRect, bgPaint);
    titleLevel.render(
        c,
        "SELECTIONNE \nTON NIVEAU :",
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
