import 'package:rainofwords/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flame_svg/flame_svg.dart';
import 'dart:ui';

class HomeView {
  final GameController game;
  Svg homeSvg;

  HomeView(this.game) {
    homeSvg = Svg('images/Backg/Farm_Mountain.svg');
  }

  void render(Canvas c) {
    homeSvg.render(c, game.screenSize.width, game.screenSize.height);
    // homeSvg.renderPosition(
    //     c, position, game.screenSize.width, game.screenSize.height);
  }

  void update(double t) {}
}
