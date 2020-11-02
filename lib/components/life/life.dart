import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:rainofwords/game_controller.dart';

class Life {
  final GameController game;
  Rect rect;
  Sprite sprite;

  Life(this.game) {
    resize();
    sprite = Sprite('lifeCloud.png');
  }

  void render(Canvas c) {
    // c.drawRect(rect, btnPaint);
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(game.tileSize * 8, game.tileSize * 0.5,
        game.tileSize * 0.8, game.tileSize * 0.6);
  }
}
