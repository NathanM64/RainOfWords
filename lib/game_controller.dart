import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/components/btn-replay.dart';
import 'components/btn-home.dart';
import 'package:rainofwords/views/view-score.dart';
import 'components/rain.dart';
import 'view.dart';
import 'views/view-home.dart';
import 'views/view-level.dart';
import 'views/view-playing.dart';
import 'components/start_button.dart';
import 'components/levels/btn_level_blue.dart';
import 'components/levels/btn_level_farm.dart';
import 'components/levels/btn_level_night.dart';
import 'components/levels/btn_level_rocky.dart';
import 'components/btn-pause.dart';
import 'package:flutter/services.dart';
import 'package:flame/keyboard.dart';
import 'dart:math';
import 'package:rainofwords/components/word_list.dart';

const SPEED = 0;

class GameController extends BaseGame with KeyboardEvents {
  Size screenSize;
  double tileSize;
  double createWordTimer;
  int score;
  TextConfig displayScore;
  Rain word;
  Random random;
  List<Rain> words = [];
  View activeView = View.home;
  HomeView homeView;
  ScoreView scoreView;
  LevelView levelView;
  int indexWord = -1;
  PlayingView playingView;

// Buttons or components
  StartButton startButton;
  ReplayButton replayButton;
  HomeButton homeButton;
  BtnLevelBlue btnLevelBlue;
  BtnLevelFarm btnLevelFarm;
  BtnLevelNight btnLevelNight;
  BtnLevelRocky btnLevelRocky;
  BtnPause btnPause;

  GameController() {
    initialize();
  }

  void initialize() async {
    words = List<Rain>();
    random = Random();
    resize(Size.zero);
    homeView = HomeView(this);
    scoreView = ScoreView(this);
    startButton = StartButton(this);
    homeButton = HomeButton(this);
    replayButton = ReplayButton(this);
    btnLevelBlue = BtnLevelBlue(this);
    btnLevelFarm = BtnLevelFarm(this);
    btnLevelNight = BtnLevelNight(this);
    btnLevelRocky = BtnLevelRocky(this);
    btnPause = BtnPause(this);
    levelView = LevelView(this);
    playingView = PlayingView(this);
    createWordTimer = 0;
    score = 0;
    displayScore = TextConfig(
        color: Color(0xFF0D1D3E), fontSize: 30.0, fontFamily: 'Chlakh');

    generateFirstWord();
  }

  void generateFirstWord() {
    random = Random();
    double randomX = random.nextDouble() * (screenSize.width - (tileSize * 4));
    word = Rain(this, getRandomWord().toUpperCase(), randomX, 1);
    words.add(word);
  }

  void generateAWord() {
    word = Rain(this, getRandomWord().toUpperCase(), getWordWidth(word), 1);
    words.add(word);
  }

  double getWordWidth(Rain aWord) {
    double boxLen = aWord.width;
    double screen = screenSize.width.truncateToDouble() - 1;
    int position = random.nextInt(screenSize.width.toInt() - (screenSize.width.toInt() / 2).truncate());
    random = Random();
    double posPbox = position + boxLen + 10;

  // Solution temporaire -- Besoin de réécrire le update
    if ( position > 0 && posPbox <= screen )  {
      return position.truncateToDouble();
    } else if (posPbox > screen) {
      return 50;
    } else {
      return 20;
    }
 }

  @override
  void render(Canvas c) {
    if (activeView == View.home) homeView.render(c);
    if (activeView == View.home) {
      startButton.render(c);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } else if (activeView == View.level) {
      levelView.render(c);
      btnLevelBlue.render(c);
      btnLevelFarm.render(c);
      btnLevelNight.render(c);
      btnLevelRocky.render(c);
    } else {
      playingView.render(c);
      words.forEach((word) {
        if (!word.destroyed()) {
          word.render(c);
          c.restore();
          c.save();
        }
      });
      displayScore.render(c, "Score: ${score}", Position(5, 5));

      btnPause.render(c);
      SystemChannels.textInput.invokeMethod('TextInput.show');
    }
  }

  @override
  void onKeyEvent(e) {
    final bool isKeyDown = e is RawKeyDownEvent;
    String letter = "${e.data.keyLabel}";
    letter = letter.toUpperCase();
    Rain wordReplacement;
    if (isKeyDown) {
      if (indexWord == -1) {
        indexWord =
            words.indexWhere((word) => word.getText().startsWith(letter));
      }
      if (indexWord != -1) {
        word = words.elementAt(indexWord);
        if (word.getText().startsWith(letter)) {
          wordReplacement =
              new Rain(this, word.text.substring(1), word.posX, word.posY);
          words.removeAt(indexWord);
          words.replaceRange(indexWord, indexWord, [wordReplacement]);
          if (wordReplacement.getText().length == 0) {
            words.elementAt(indexWord).complete();
            indexWord = -1;
            score += 10;
          }
        }
      }
    }
  }

  @override
  void update(double t) {
    this.createWordTimer += t;
    if (this.createWordTimer >= 2) {
      this.createWordTimer = 0;
      generateAWord();
    }
    if (indexWord != -1 && words.elementAt(indexWord).getText() == '')
      indexWord = -1;

    words.forEach((word) => word.update(t));
    words.forEach((word) {
      if (word.destroyed()) {
        word.setText('');
        if (word.destroyed() && !word.getStatus()) {
          score -= 50;
        }
      }
    });
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
    startButton?.resize();
    homeButton?.resize();
    replayButton?.resize();
    homeView?.resize();
    scoreView?.resize();
    playingView?.resize();
    levelView?.resize();
    btnLevelBlue?.resize();
    btnLevelFarm?.resize();
    btnLevelNight?.resize();
    btnLevelRocky?.resize();
    btnPause?.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    if (!isHandled && btnLevelBlue.rect.contains(d.globalPosition)) {
      if (activeView == View.level) {
        btnLevelBlue.onTapDown();
        isHandled = true;
      }
    } else if (btnLevelFarm.rect.contains(d.globalPosition)) {
      if (activeView == View.level) {
        btnLevelFarm.onTapDown();
        isHandled = true;
      }
    } else if (btnLevelNight.rect.contains(d.globalPosition)) {
      if (activeView == View.level) {
        btnLevelNight.onTapDown();
        isHandled = true;
      }
    } else if (btnLevelRocky.rect.contains(d.globalPosition)) {
      if (activeView == View.level) {
        btnLevelRocky.onTapDown();
        isHandled = true;
      }
    }
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home) {
        startButton.onTapDown();
        isHandled = true;
      }
    }
    if (!isHandled && btnPause.rect.contains(d.globalPosition)) {
      if (activeView == View.playing) {
        btnPause.onTapDown();
        isHandled = true;
      }
    }
    if (!isHandled && homeButton.rect.contains(d.globalPosition)) {
      if (activeView == View.score) {
        homeButton.onTapDown();
        isHandled = true;
      }
    }
    if (!isHandled && replayButton.rect.contains(d.globalPosition)) {
      if (activeView == View.score) {
        replayButton.onTapDown();
        isHandled = true;
      }
    }
  }
}
