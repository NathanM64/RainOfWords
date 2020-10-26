import 'package:flame/sprite.dart';
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
import 'components/levels/btn_level_blue.dart';
import 'components/levels/btn_level_farm.dart';
import 'components/levels/btn_level_night.dart';
import 'components/levels/btn_level_rocky.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:rainofwords/components/word_list.dart';

const SPEED = 0.1;

class GameController extends Game {
  Size screenSize;
  double tileSize;
  double createWordTimer = 0;
  Rain word;
  Random random;
  List<Rain> words = [];
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

  GameController() {
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
    levelView = LevelView(this);
    playingView = PlayingView(this);

    generateFirstWord();
  }

  void generateFirstWord() {
        random = Random();
    double randomX = random.nextDouble() * (screenSize.width - (tileSize * 4));
    word = Rain(this, getRandomWord().toUpperCase(), randomX);
    words.add(word);
  }

  void generateAWord() {
    random = Random();
    double randomX = random.nextDouble() * (screenSize.width - (word.width - 1));
    word = Rain(this, getRandomWord().toUpperCase(), randomX);
    words.add(word);
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
        word.render(c);
        c.restore();
        c.save();
      });
      SystemChannels.textInput.invokeMethod('TextInput.show');
    }
  }

  @override
  void update(double t) {
    this.createWordTimer += t;
    if (this.createWordTimer >= 2) {
      this.createWordTimer = 0;
      generateAWord();
    }
    words.forEach((word) => word.update(t));
    words.removeWhere((word) {
      return word.destroy();
    });
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
  }
}
