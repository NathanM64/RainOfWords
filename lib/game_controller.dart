import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';

class GameController extends Game {
  Size screenSize;
  double tileSize;

  GameController() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
  }

  @override
  void render(Canvas c) {
    print('Render');
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xff576574);
    c.drawRect(background, backgroundPaint);
  }

  @override
  void update(double t) {
    print('Update');
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }
}
