import 'package:flame/flame.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/components/rain.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class GameController extends BaseGame {
  Size screenSize;
  double tileSize;
  Rain word;
  List<Rain> words;
  Random random;

  GameController() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    random = Random();
    words = List<Rain>();
    generateAWord();
  }

  void generateAWord() {
    double randomX = random.nextDouble() * (screenSize.width - tileSize);
    word = Rain(this, 'Salut', randomX, 0);
    words.add(word);
  }

  @override
  void render(Canvas c) {
    print('Render');
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xff17555f);
    c.drawRect(background, backgroundPaint);
    words.forEach((word) {
      word.render(c);
    });

  }

  @override
  void update(double t) {}

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }
}
