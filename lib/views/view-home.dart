import 'package:flame/sprite.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flame_svg/flame_svg.dart';
import 'dart:ui';

class HomeView {
  final GameController game;
  Svg homeSvg;
  Rect homeRect;
  Sprite homeSprite;

  HomeView(this.game) {
    resize();
    homeSprite = Sprite('Backg/farm_moutain.png');
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
