import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:rainofwords/game_controller.dart';
import 'package:rainofwords/view.dart';

class StartButton {
  final GameController game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    resize();
    sprite = Sprite('title_home.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
        game.tileSize * 1.5,
        (game.screenSize.height * .25) - (game.tileSize * 1.5),
        game.tileSize * 6,
        game.tileSize * 6);
  }

  void onTapDown() {
    game.activeView = View.playing;
    print('Bien joué');
  }
}
