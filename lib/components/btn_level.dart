import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';

class BtnLevel {
  final GameController game;
  Rect rect;
  Sprite sprite;
  // Paint btnPaint;

  BtnLevel(this.game) {
    resize();
    sprite = Sprite('Backg/rocky_mountain.png');
    // btnPaint = Paint()..color = Color(0xff17555f);
  }

  void render(Canvas c) {
    // c.drawRect(rect, btnPaint);
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
        game.tileSize * 1.2,
        (game.screenSize.height * .15) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 2);
  }

  void onTapDown() {
    game.activeView = View.playing;
    print('Bien joué');
  }
}
