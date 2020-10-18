import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/components/rain.dart';
import 'package:rainofwords/view.dart';
import 'package:rainofwords/views/view-home.dart';
import 'package:rainofwords/views/start_button.dart';
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
  StartButton startButton;

  GameController() {
    initialize();
  }

  void initialize() async {
    words = List<Rain>();
    random = Random();
    resize(Size.zero);
    homeView = HomeView(this);
    startButton = StartButton(this);
    // resize(await Flame.util.initialDimensions());

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
    } else {
      Rect background =
          Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
      Paint backgroundPaint = Paint()..color = Color(0xff17555f);
      c.drawRect(background, backgroundPaint);
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
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home) {
        startButton.onTapDown();
        isHandled = true;
      }
    }
  }
}
