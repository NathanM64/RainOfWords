import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';

class BtnLevelBlue {
  final GameController game;
  Rect rect;
  Sprite sprite;
  TextConfig titleLevels = TextConfig(
    fontSize: 35,
    fontFamily: 'Chlakh',
    color: Color(0xffffffff),
    textAlign: TextAlign.center,
  );

  BtnLevelBlue(this.game) {
    resize();
    sprite = Sprite('1stLevelBackg.png');
  }

  void render(Canvas c) {
    // c.drawRect(rect, btnPaint);
    sprite.renderRect(c, rect);
    titleLevels.render(
        c,
        "Blue Mountain",
        Position(
          game.tileSize * 2.5,
          (game.screenSize.height * 0.85) - (game.tileSize * 9),
        ));
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
        game.tileSize * 1.2,
        (game.screenSize.height * .38) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 2.5);
  }

  void onTapDown([bool bool]) {
    game.onLevelBlue = true;
    game.activeView = View.playing;
    game.score = 0;
    game.speed = 0;
    game.lifes = 3;
    game.words.removeRange(0, game.words.length);
  }
}
