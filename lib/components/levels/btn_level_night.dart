import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';

class BtnLevelNight {
  final GameController game;
  Rect rect;
  Sprite sprite;
  TextConfig titleLevels = TextConfig(
    fontSize: 35,
    fontFamily: 'Chlakh',
    color: Color(0xfff3e5f5),
    textAlign: TextAlign.center,
  );
  // Paint btnPaint;

  BtnLevelNight(this.game) {
    resize();
    sprite = Sprite('3rdLevelBackg.png');
    // btnPaint = Paint()..color = Color(0xff17555f);
  }

  void render(Canvas c) {
    // c.drawRect(rect, btnPaint);
    sprite.renderRect(c, rect);
    titleLevels.render(
        c,
        "Night Mountain",
        Position(
          game.tileSize * 2.5,
          (game.screenSize.height * 1.2) - (game.tileSize * 9),
        ));
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
        game.tileSize * 1.2,
        (game.screenSize.height * .72) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 2.5);
  }

  void onTapDown() {
    game.activeView = View.playing;
    game.score = 0;
    game.words.removeRange(0, game.words.length);
    game.onLevelNight = true;
  }
}
