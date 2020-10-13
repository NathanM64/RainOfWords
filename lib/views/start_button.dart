import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:rainofwords/game_controller.dart';

class StartButton {
  final GameController game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
      80,
      225,
      225,
      225,
    );
    sprite = Sprite('title_home.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void onTap() {}
}
