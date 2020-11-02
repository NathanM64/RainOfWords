import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:rainofwords/game_controller.dart';

class ScoreDisplay {
  final GameController game;

  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  ScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xFF0D1D3E),
      fontSize: 30,
      fontFamily: 'Chlakh',
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') != game.score.toString()) {
      painter.text = TextSpan(
        text: 'score: ' + game.score.toString(),
        style: textStyle,
      );

      painter.layout();

      position = Offset(
        (game.screenSize.width) / (painter.width / 2),
        (game.screenSize.height * .02) - (painter.height / 2),
      );
    }
  }
}
