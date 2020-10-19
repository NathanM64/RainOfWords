import 'dart:ui';
import 'package:flame/palette.dart';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:rainofwords/game_controller.dart';

TextConfig regular = TextConfig(color: BasicPalette.white.color);
TextConfig tiny = regular.withFontSize(20.0);
const SPEED = 0.2;

class Rain extends TextBoxComponent {
  GameController game;
  double posX;
  String text;
  double posY;
  bool complete = false;
  Rain(this.game, text, this.posX, this.posY) : super(text, config: tiny) {
    this.text = text;
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
    c.drawRect(rect, Paint()..color = Color(0xFFFF00FF).withOpacity(0));
  }

  @override
  void update(double t) {
    super.update(t);
    this.setPosY(this.posY + SPEED);
  }
}
