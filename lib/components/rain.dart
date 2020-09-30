import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:rainofwords/game_controller.dart';

class Rain {
  final GameController game;
  Rect rainRect;
  Paint rainPaint;

  Rain(this.game, double x, double y) {
    rainRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    rainPaint = Paint();
    rainPaint.color = Color(0xff68a5b6);
  }
  void render(Canvas c) {
//
    c.drawRect(rainRect, rainPaint);
  }

  void update(double t) {
    //
  }
}
