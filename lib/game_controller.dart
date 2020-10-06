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

class GameController extends Game {
  Size screenSize;
  double tileSize;
  List<Rain> rains;
  Random random;
  View activeView = View.home;
  HomeView homeView;

  GameController() {
    initialize();
  }

  void initialize() async {
    rains = List<Rain>();
    random = Random();

    homeView = HomeView(this);
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
    SystemChannels.textInput.invokeMethod('TextInput.show');
    homeView.render(c);
  }

  @override
  void update(double t) {
    rains.forEach((Rain rain) => rain.update(t));
    print('Update');
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }
}
