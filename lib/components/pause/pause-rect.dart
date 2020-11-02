import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:rainofwords/game_controller.dart';

class PauseRect {
  final GameController game;
  Rect rect;
  RRect rRect;
  var path = Path();
  TextConfig titleHome = TextConfig(
      fontSize: 60,
      fontFamily: 'Chlakh',
      textAlign: TextAlign.center,
      color: Color(0xFF0D1D3E));

  TextConfig titlePause = TextConfig(
      fontSize: 40,
      fontFamily: 'Chlakh',
      textAlign: TextAlign.center,
      color: Color(0xFF0D1D3E));

  PauseRect(this.game) {
    resize();
  }

  void render(Canvas c) {
    path.addRRect(rRect);
    c.drawPath(path, Paint()..color = Color(0xFFCECECE));
    titleHome.render(
        c,
        "Pause",
        Position(
          game.tileSize * 3.2,
          (game.screenSize.height * 0.7) - (game.tileSize * 10),
        ));
    titlePause.render(
        c,
        "Score :\n${game.score}",
        Position(
          game.tileSize * 3.5,
          (game.screenSize.height * 0.8) - (game.tileSize * 10),
        ));
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(game.tileSize * 1, game.tileSize * 2,
        game.tileSize * 8, game.tileSize * 8);
    rRect = RRect.fromRectAndRadius(rect, Radius.circular(15));
  }
}
