
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:rainofwords/game_controller.dart';

class ScoreView {
  final GameController game;
  Rect scoreRect;
  Sprite scoreSprite;

  TextConfig h1 = TextConfig(
      fontSize: 50, 
      fontFamily: 'Chlakh', 
      textAlign: TextAlign.center, 
      color:  Color(0xFF0D1D3E)
    );
  TextConfig h2 = TextConfig(
      fontSize: 40, 
      fontFamily: 'Chlakh', 
      textAlign: TextAlign.center, 
      color:  Color(0xFF0D1D3E)
    );
  TextConfig score = TextConfig(
      fontSize: 36, 
      fontFamily: 'Quando', 
      textAlign: TextAlign.center, 
      color:  Color(0xFF0D1D3E)
    );
  TextConfig h3 = TextConfig(
      fontSize: 36, 
      fontFamily: 'Chlakh', 
      textAlign: TextAlign.center, 
      color:  Color(0xFF0D1D3E)
    );
  
  ScoreView(this.game) {
    resize();
    scoreSprite = Sprite('Backg/home.png');
  }

  Text txtTitle = Text("Score :");
  Text txtTaPartie = Text("Ta Partie");
  Text txtHighScoreTitle = Text("Meilleur score");
  Text txtReplay = Text("Rejouer");
  Text txtHome = Text("Menu principal");
  Text txtPts = Text("pts");
  Text valueScore = Text("1233");
  Text valueHighScore = Text("123300");


  void render(Canvas c) {
    scoreSprite.renderRect(c, scoreRect);
    h1.render(drawTitleBRect(c), txtTitle.data, Position(
          game.tileSize * 3.25,
          (game.screenSize.height * .15) - (game.tileSize * 1.75),
        ));
    h1.render(drawTaPartie(c), txtTaPartie.data, Position(
          game.tileSize * 2.3,
          (game.screenSize.height * 0.33) - (game.tileSize * 1.75),
        ));
    h2.render(drawHighScore(c), txtHighScoreTitle.data, Position(
          game.tileSize * 1.7,
          (game.screenSize.height * 0.58) - (game.tileSize * 1.75),
        ));

    score.render(nothing(c) , valueScore.data, Position(
          game.tileSize * 2.3,
          (game.screenSize.height * 0.43) - (game.tileSize * 1.75),
        ));
    h3.render(nothing(c), txtPts.data, Position(
          game.tileSize * 7,
          (game.screenSize.height * 0.44) - (game.tileSize * 1.75),
        ));
    score.render(nothing(c) , valueHighScore.data, Position(
          game.tileSize * 2.3,
          (game.screenSize.height * 0.688) - (game.tileSize * 1.75),
        ));
    h3.render(nothing(c), txtPts.data, Position(
          game.tileSize * 7,
          (game.screenSize.height * 0.7) - (game.tileSize * 1.75),
        ));
  }

  void resize() {
    scoreRect = Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
  }

  Canvas drawTitleBRect(Canvas dtbr) {
    Rect rect = Rect.fromLTWH(
        game.tileSize * 1,
        (game.screenSize.height * .12) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 2);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(15));
    var path = Path();
    path.addRRect(rrect);

    dtbr.drawPath(path, Paint()..color = Color(0xFFFFFFFF));
    return dtbr;
  }

  Canvas drawTaPartie(Canvas dtp) {
    Rect rect = Rect.fromLTWH(
        game.tileSize * 1,
        (game.screenSize.height * .30) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 4);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(15));
    var path = Path();
    path.addRRect(rrect);

    dtp.drawPath(path, Paint()..color = Color(0xFFFFFFFF));
    return dtp;
  }

  Canvas drawHighScore(Canvas dhg) {
    Rect rect = Rect.fromLTWH(
        game.tileSize * 1,
        (game.screenSize.height * .55) - (game.tileSize * 1.5),
        game.tileSize * 8,
        game.tileSize * 4);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(15));
    var path = Path();
    path.addRRect(rrect);

    dhg.drawPath(path, Paint()..color = Color(0xFFFFFFFF));
    return dhg;
  }

  Canvas nothing(Canvas n) {
    return n;
  }
}