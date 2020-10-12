import 'package:flame/flame.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/components/rain.dart';
import 'package:rainofwords/view.dart';
import 'package:rainofwords/views/view-home.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class GameController extends BaseGame {
  Size screenSize;
  double tileSize;
  Rain word;
  List<Rain> words;
  Random random;
  View activeView = View.home;
  HomeView homeView;

  GameController() {
    initialize();
  }

  void initialize() async {
    words = List<Rain>();
    random = Random();

    homeView = HomeView(this);
    resize(await Flame.util.initialDimensions());

    generateAWord();
  }

  void generateAWord() {
    double randomX = random.nextDouble() * (screenSize.width - tileSize);
    word = Rain(this, 'Salut', randomX, 0);
    words.add(word);
  }

  @override
  void render(Canvas c) {
    if (activeView != View.home) {
      homeView.render(c);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } else {
      Rect background =
          Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
      Paint backgroundPaint = Paint()..color = Color(0xff17555f);
      c.drawRect(background, backgroundPaint);
      words.forEach((word) {
        word.render(c);
      });
      SystemChannels.textInput.invokeMethod('TextInput.show');
    }
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
