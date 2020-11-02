import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/rain.dart';
import 'view.dart';
import 'views/view-home.dart';
import 'views/view-level.dart';
import 'views/view-playing.dart';
import 'components/start_button.dart';
import 'components/score-display.dart';

import 'components/levels/btn_level_blue.dart';
import 'components/levels/btn_level_farm.dart';
import 'components/levels/btn_level_night.dart';
import 'components/levels/btn_level_rocky.dart';
import 'components/pause/pause-rect.dart';
import 'components/pause/btn-game.dart';
import 'components/pause/btn-pause.dart';
import 'package:flutter/services.dart';
import 'package:flame/keyboard.dart';
import 'dart:math';
import 'package:rainofwords/components/word_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SPEED = 0;

class GameController extends BaseGame with KeyboardEvents {
  final SharedPreferences storage;

  Size screenSize;
  double tileSize;

  double speedUpTimer;
  double createWordTimer;
  int score;
  TextConfig displayScore;
  Rain word;
  double speed;
  Random random;
  List<Rain> words = [];
  int indexWord = -1;
  bool onLevelBlue = false;

// Views
  ScoreDisplay scoreDisplay;

  View activeView = View.home;
  HomeView homeView;
  LevelView levelView;
  PlayingView playingView;

// Buttons
  StartButton startButton;
  BtnLevelBlue btnLevelBlue;
  BtnLevelFarm btnLevelFarm;
  BtnLevelNight btnLevelNight;
  BtnLevelRocky btnLevelRocky;
  BtnPause btnPause;
  PauseRect pauseRect;
  BtnGame btnGame;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    words = List<Rain>();
    random = Random();
    resize(Size.zero);
    homeView = HomeView(this);
    startButton = StartButton(this);
    btnLevelBlue = BtnLevelBlue(this);
    btnLevelFarm = BtnLevelFarm(this);
    btnLevelNight = BtnLevelNight(this);
    btnLevelRocky = BtnLevelRocky(this);
    btnPause = BtnPause(this);
    pauseRect = PauseRect(this);
    btnGame = BtnGame(this);
    scoreDisplay = ScoreDisplay(this);

    levelView = LevelView(this);
    playingView = PlayingView(this);

    speed = 0;
    speedUpTimer = 0;
    createWordTimer = 0;
    score = 0;

    generateFirstWord();
  }

  void generateFirstWord() {
    random = Random();
    double randomX = random.nextDouble() * (screenSize.width - (tileSize * 4));
    word = Rain(this, getRandomWord().toUpperCase(), randomX, 1, this.speed);
    words.add(word);
  }

  void generateAWord() {
    random = Random();
    double randomX =
        random.nextDouble() * (screenSize.width - (word.width + 2));
    word = Rain(this, getRandomWord().toUpperCase(), randomX, 1, this.speed);
    word = Rain(
        this, getRandomWord().toUpperCase(), getWordWidth(word), 1, this.speed);
    words.add(word);
  }

  double getWordWidth(Rain aWord) {
    double boxLen = aWord.width;
    double screen = screenSize.width.truncateToDouble() - 1;
    int position = random.nextInt(
        screenSize.width.toInt() - (screenSize.width.toInt() / 2).truncate());
    random = Random();
    double posPbox = position + boxLen + 10;

    // Solution temporaire -- Besoin de réécrire le update
    if (position > 0 && posPbox <= screen) {
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
      SystemChannels.textInput.invokeMethod('TextInput.show');
      words.forEach((word) {
        if (!word.destroyed()) {
          word.render(c);
          c.restore();
          c.save();
        }
      });
      if (runOnCreation == true) {
        btnPause.render(c);
        if (activeView == View.playing || activeView == View.lost)
          scoreDisplay.render(c);
      } else {
        pauseRect.render(c);
        btnGame.render(c);
        pauseEngine();
      }
    }
  }

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
          wordReplacement = new Rain(
              this, word.text.substring(1), word.posX, word.posY, this.speed);
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
    this.speedUpTimer += t;
    if (this.speedUpTimer >= 10) {
      this.speed += 0.2;
      words.forEach((word) => word.faster(speed));
      this.speedUpTimer = 0;
    }

    this.createWordTimer += t;
    if (this.createWordTimer >= 2) {
      this.createWordTimer = 0;
      generateAWord();
    }
    if (indexWord != -1 && words.elementAt(indexWord).getText() == '')
      indexWord = -1;

    words.forEach((word) => word.update(t));
    words.forEach((word) {
      if (word.destroyed()) word.setText('');
    });
    if (activeView == View.playing) scoreDisplay.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
    startButton?.resize();
    homeView?.resize();
    playingView?.resize();
    levelView?.resize();
    btnLevelBlue?.resize();
    btnLevelFarm?.resize();
    btnLevelNight?.resize();
    btnLevelRocky?.resize();
    btnPause?.resize();
    pauseRect?.resize();
    btnGame?.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    if (!isHandled && btnLevelBlue.rect.contains(d.globalPosition)) {
      if (activeView == View.level) {
        btnLevelBlue.onTapDown();
        onLevelBlue = true;
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
    if (!isHandled && btnGame.rect.contains(d.globalPosition)) {
      if (activeView == View.playing) {
        btnGame.onTapDown();
        isHandled = true;
      }
    }
  }
}
