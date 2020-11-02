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
import 'views/view-playing-blue.dart';
import 'views/view-playing-farm.dart';
import 'views/view-playing-rocky.dart';
import 'views/view-playing-night.dart';
import 'components/start_button.dart';
import 'components/score-display.dart';

import 'components/levels/btn_level_blue.dart';
import 'components/levels/btn_level_farm.dart';
import 'components/levels/btn_level_night.dart';
import 'components/levels/btn_level_rocky.dart';
import 'components/pause/pause-rect.dart';
import 'components/pause/btn-game.dart';
import 'components/pause/btn-pause.dart';
import 'components/pause/btn-menu.dart';
import 'components/life/life.dart';
import 'components/life/life2.dart';
import 'components/life/life3.dart';

import 'package:flutter/services.dart';
import 'package:flame/keyboard.dart';
import 'package:flame/flame.dart';
import 'dart:math';
import 'package:rainofwords/components/word_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SPEED = 0;

class GameController extends BaseGame with KeyboardEvents {
  final SharedPreferences storage;

  Size screenSize;
  double tileSize;

  double speed;
  Random random;
  double createWordTimer;
  double speedUpTimer;
  TextConfig displayScore;
  Rain word;
  List<Rain> words = [];
  int indexWord = -1;

  int score;
// Vies
  int lifes;
  Life life;
  Life2 life2;
  Life3 life3;
// OnLevels
  bool onLevelBlue = false;
  bool onLevelNight = false;
  bool onLevelFarm = false;
  bool onLevelRocky = false;

// Views
  ScoreDisplay scoreDisplay;

  View activeView = View.home;
  HomeView homeView;
  ScoreView scoreView;
  LevelView levelView;
  PlayingViewBlue playingViewBlue;
  PlayingViewNight playingViewNight;
  PlayingViewFarm playingViewFarm;
  PlayingViewRocky playingViewRocky;

// Buttons or components
  StartButton startButton;
  ReplayButton replayButton;
  HomeButton homeButton;
  BtnLevelBlue btnLevelBlue;
  BtnLevelFarm btnLevelFarm;
  BtnLevelNight btnLevelNight;
  BtnLevelRocky btnLevelRocky;
  BtnPause btnPause;
  PauseRect pauseRect;
  BtnGame btnGame;
  BtnMenu btnMenu;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    Flame.audio.playLongAudio('rain.mp3');
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
    pauseRect = PauseRect(this);
    btnGame = BtnGame(this);
    btnMenu = BtnMenu(this);
    scoreDisplay = ScoreDisplay(this);
    life = Life(this);
    life2 = Life2(this);
    life3 = Life3(this);

    levelView = LevelView(this);
    playingViewBlue = PlayingViewBlue(this);
    playingViewNight = PlayingViewNight(this);
    playingViewFarm = PlayingViewFarm(this);
    playingViewRocky = PlayingViewRocky(this);

    speed = 0;
    speedUpTimer = 0;
    createWordTimer = 0;
    score = 0;
    lifes = 3;

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
      if (onLevelBlue == true) {
        playingViewBlue.render(c);
      } else if (onLevelNight == true) {
        playingViewNight.render(c);
      } else if (onLevelFarm == true) {
        playingViewFarm.render(c);
      } else if (onLevelRocky == true) {
        playingViewRocky.render(c);
      } else {
        print(Error());
      }
      SystemChannels.textInput.invokeMethod('TextInput.show');
      words.forEach((word) {
        if (!word.destroyed()) {
          word.render(c);
          c.restore();
          c.save();
        }
      });
      if (lifes == 3) {
        life3.render(c);
        life2.render(c);
        life.render(c);
      } else if (lifes == 2) {
        life2.render(c);
        life.render(c);
      } else if (lifes == 1) {
        life.render(c);
      } else if (lifes == 0) {
        activeView = View.home;
      }
      // Condition Pause
      if (runOnCreation == true) {
        btnPause.render(c);
        if (activeView == View.playing || activeView == View.lost)
          scoreDisplay.render(c);
      } else {
        pauseRect.render(c);
        btnGame.render(c);
        btnMenu.render(c);
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
      if (word.destroyed() && !word.getStatus() && activeView == View.playing)
        lifes--;
    });
    if (activeView == View.playing) scoreDisplay.update(t);
  }

  @override
  void resize(Size size) {
    // Par défaut
    screenSize = size;
    tileSize = screenSize.width / 10;
    // Page Home
    startButton?.resize();
    homeButton?.resize();
    replayButton?.resize();
    homeView?.resize();
    scoreView?.resize();
    // playingView?.resize();
    // Vies
    life?.resize();
    life2?.resize();
    life3?.resize();
    // Differents Backgrounds levels
    playingViewBlue?.resize();
    playingViewNight?.resize();
    playingViewFarm?.resize();
    playingViewRocky?.resize();
    // Page Levels
    levelView?.resize();
    btnLevelBlue?.resize();
    btnLevelFarm?.resize();
    btnLevelNight?.resize();
    btnLevelRocky?.resize();
    // Btn en jeu
    btnPause?.resize();
    pauseRect?.resize();
    btnGame?.resize();
    btnMenu?.resize();
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
      }
    }
    if (!isHandled && btnGame.rect.contains(d.globalPosition)) {
      if (activeView == View.playing) {
        btnGame.onTapDown();
        isHandled = true;
      }
    }
    if (!isHandled && btnMenu.rect.contains(d.globalPosition)) {
      if (activeView == View.playing) {
        btnMenu.onTapDown();
        isHandled = true;
      }
    }
  }
}
