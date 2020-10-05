import 'package:flame/flame.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rainofwords/components/rain.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class GameController extends Game {
  Size screenSize;
  double tileSize;
  List<Rain> rains;
  Random random;

  GameController() {
    initialize();
  }

  void initialize() async {
    rains = List<Rain>();
    random = Random();

    resize(await Flame.util.initialDimensions());

    spanRain();
  }

  void spanRain() {
    double x = random.nextDouble() * (screenSize.width - tileSize);
    rains.add(Rain(this, x, 50));
  }

  @override
  void render(Canvas c) {
    print('Render');
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xff17555f);
    c.drawRect(background, backgroundPaint);

    rains.forEach((Rain rain) => rain.render(c));
  }

  @override
  void update(double t) {
    rains.forEach((Rain rain) => rain.update(t));
    print('Update');
    SystemChannels.textInput.invokeMethod('TextInput.hidden');
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }
}
