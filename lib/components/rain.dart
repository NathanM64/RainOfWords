import 'dart:ui';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/game_controller.dart';

TextConfig regular = TextConfig(color: Color(0xFF000000), fontFamily: 'Chlakh');
TextConfig tiny = regular.withFontSize(34.0);
const SPEED = 1;

class Rain extends TextBoxComponent {
  GameController game;
  double posX;
  String text;
  double posY;
  bool isLocked;
  bool complete = false;
  Rain(this.game, text, this.posX, this.posY) : super(text, config: tiny) {
    this.text = text;
    this.isLocked = false;
    this.p = Position(this.posX, this.posY);
    this.setByPosition(p);
  }
  void lock() {
    this.isLocked = true;
  }

  bool getStatus() {
    return this.isLocked;
  }

  void setPosY(double y) {
    this.posY = y;
    updatePos();
  }

  void setPosX(double x) {
    this.posX = x;
    updatePos();
  }

  void setText(String t) {
    this.text = t;
  }

  String getText() {
    return this.text;
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
    return this.y >= 382 || this.complete;
  }

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(15));
    var path = Path();
    path.addRRect(rrect);

    c.drawPath(path, Paint()..color = Color(0xFFFFFFFF));
  }

  @override
  void update(double t) {
    this.setPosY(this.posY + SPEED);
    if (this.getText() == '' && !this.getStatus()) this.complete = true;
  }
}
