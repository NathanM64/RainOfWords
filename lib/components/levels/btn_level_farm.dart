import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';

class BtnLevelFarm {
  final GameController game;
  Rect rect;
  Sprite sprite;
  // Paint btnPaint;

  BtnLevelFarm(this.game) {
    resize();
    sprite = Sprite('2ndLevelBackg.png');
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
        (game.screenSize.height * .55) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 2);
  }

  void onTapDown() {
    game.activeView = View.playing;
    print('Bien joué');
  }
}
