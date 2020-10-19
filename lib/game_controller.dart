import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/components/rain.dart';
import 'package:rainofwords/view.dart';
import 'package:rainofwords/views/view-home.dart';
import 'package:rainofwords/views/view-level.dart';
import 'package:rainofwords/views/view-playing.dart';
import 'package:rainofwords/components/start_button.dart';
import 'package:rainofwords/components/btn_level.dart';
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

  StartButton startButton;
  BtnLevel btnLevel;

  GameController() {
    initialize();
  }

  void initialize() async {
    words = List<Rain>();
    random = Random();
    resize(Size.zero);
    homeView = HomeView(this);
    startButton = StartButton(this);
    btnLevel = BtnLevel(this);
    levelView = LevelView(this);
    playingView = PlayingView(this);

    generateAWord();
  }

  void generateAWord() {
    random = Random();
    double randomX = random.nextDouble() * (screenSize.width - tileSize);
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
      btnLevel.render(c);
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
    btnLevel?.resize();
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    if (!isHandled && btnLevel.rect.contains(d.globalPosition)) {
      if (activeView == View.level) {
        btnLevel.onTapDown();
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
