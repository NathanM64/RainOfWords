import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/components/rain.dart';
import 'package:rainofwords/view.dart';
import 'package:rainofwords/views/view-home.dart';
import 'package:rainofwords/views/view-level.dart';
import 'package:rainofwords/components/start_button.dart';
import 'package:rainofwords/components/btn_level.dart';
import 'package:flutter/services.dart';
import 'package:flame/keyboard.dart';
import 'dart:math';
import 'package:rainofwords/components/word_list.dart';

const SPEED = 0;

class GameController extends BaseGame with KeyboardEvents {
  Size screenSize;
  double tileSize;
  double createWordTimer = 0;
  Rain word;
  Random random;
  List<Rain> words = [];
  View activeView = View.home;
  HomeView homeView;
  LevelView levelView;
  bool lockedWord = null;
  int indexWord = -1;

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

    generateAWord();
  }

  void generateAWord() {
    random = Random();
    double randomX = random.nextDouble() * (screenSize.width - tileSize);
    word = Rain(this, getRandomWord().toUpperCase(), randomX, 1);
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
      Rect background =
          Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
      Paint backgroundPaint = Paint()..color = Color(0xff17555f);
      c.drawRect(background, backgroundPaint);
      words.forEach((word) {
        if (!word.destroy()) {
          word.render(c);
          c.restore();
          c.save();
        }
      });
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
          if (wordReplacement.getText().length == 0) indexWord = -1;
          print(indexWord);
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
      if (word.destroy()) word.setText('');
    });
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
    startButton?.resize();
    homeView?.resize();
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
