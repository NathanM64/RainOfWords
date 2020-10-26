import 'dart:ui';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/game_controller.dart';

TextConfig regular = TextConfig(color : Color(0xFF0D1D3E), fontFamily: 'Chlakh');
TextConfig tiny = regular.withFontSize(34.0);
const SPEED = 1;

class Rain extends TextBoxComponent {
  GameController game;
  double posX;
  double posY;
  Rain(this.game, text, this.posX) : super(text, config: tiny) {
    this.posY = 1;
    this.p = Position(this.posX, this.posY);
    this.setByPosition(p);
  }

  void setPosY(double y) {
    this.posY = y;
    updatePos();
  }

  void setPosX(double x) {
    this.posX = x;
    updatePos();
  }

  double getPosX() {
    return this.posX;
  }

  double getPosY() {
    return this.posY;
  }

  void updatePos() {
    this.p = Position(this.posX, this.posY);
    this.setByPosition(p);
  }

  bool destroy() {
    return this.y >= 382;
  }

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(15));
      var path = Path();
      path.addRRect(rrect);

    c.drawPath(path, Paint()..color = Color(0xFFFFFFFF));
    // c.drawShadow(path, Color(0xFF000000), 2, false);
  }

  @override
  void update(double t) {
    this.setPosY(this.posY + SPEED);
  }
}
